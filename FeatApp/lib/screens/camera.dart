import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:feat/screens/camera_preview.dart';


class CameraPage extends StatefulWidget {

  CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller; // 카메라 컨트롤러
  Future<void>? _initializeControllerFuture; // 카메라 초기화 완료를 위한 Future
  bool _isFlashOn = false; // 후레쉬 상태 플래그
  int _selectedCameraIndex = 0; // 현재 선택된 카메라 인덱스 (0: 후면, 1: 전면)
  File? _galleryImage; // 갤러리에서 선택한 이미지 저장용
  String? _imagePath; // 선택한 이미지 경로 저장용
  List<CameraDescription>? _cameras;

  final ImagePicker _picker = ImagePicker(); // ImagePicker 인스턴스

  @override
  void initState() {
    super.initState();
    _initializeCameraAndPermissions();
  }

  Future<void> _initializeCameraAndPermissions() async {
    // 카메라 목록을 가져오기
    _cameras = await availableCameras();

    // 권한 요청
    final granted = await requestPermissions();
    if (granted && _cameras!.isNotEmpty) {
      _initializeCamera(_selectedCameraIndex);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('카메라 및 저장소 권한이 필요합니다.')),
        );
      });
    }
  }

  // 카메라와 저장소 권한을 요청
  Future<bool> requestPermissions() async {
    var cameraStatus = await Permission.camera.status;
    var storageStatus = await Permission.storage.status;

    // 카메라 권한 요청
    if (cameraStatus.isDenied) {
      cameraStatus = await Permission.camera.request();
    }

    // 저장소 권한 요청
    if (storageStatus.isDenied) {
      storageStatus = await Permission.storage.request();
    }

    return cameraStatus.isGranted && storageStatus.isGranted;
  }

  // 선택한 카메라 초기화
  void _initializeCamera(int cameraIndex) {
    _controller = CameraController(
      _cameras![cameraIndex], // 선택된 카메라
      ResolutionPreset.high, // 해상도 설정
    );
    setState(() {
      _initializeControllerFuture = _controller!.initialize(); // 카메라 초기화
    });
  }

  // 사진 촬영 및 저장
  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture; // 카메라 초기화 완료 대기
      final image = await _controller!.takePicture(); // 사진 촬영

      // 앱의 문서 디렉토리에 사진 저장
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/${DateTime.now()}.png';

      final file = File(path);
      await file.writeAsBytes(await image.readAsBytes());

      setState(() {
        _imagePath = path; // 이미지 경로 저장
      });

      // 프리뷰 화면으로 이동
      Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(imagePath: _imagePath!),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  // 후레쉬 전환
  void _toggleFlash() async {
    if (_controller != null) {
      _isFlashOn = !_isFlashOn;
      await _controller!.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off,
      );
      setState(() {});
    }
  }

  // 카메라 전환
  void _switchCamera() {
    if (_cameras != null && _cameras!.length > 1) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras!.length;
      _initializeCamera(_selectedCameraIndex);
    }
  }

  // 갤러리에서 이미지 가져오기
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _galleryImage = File(pickedFile.path); // 선택한 이미지 저장
        _imagePath = pickedFile.path; // 이미지 경로 저장
      });

      // 프리뷰 화면으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(imagePath: _imagePath!),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose(); // 카메라 컨트롤러 리소스 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final containerWidth = size.width * 0.92;
    final containerHeight = containerWidth * 16 / 9;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 카메라 미리보기
          if (_initializeControllerFuture != null)
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Positioned(
                    bottom: size.height * 0.13,
                    left: size.width * 0.04,
                    right: size.width * 0.04,
                    child: Container(
                      width: containerWidth,
                      height: containerHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CameraPreview(_controller!),
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          // 후레쉬 버튼
          Positioned(
            left: size.width * 0.06,
            bottom: size.height * 0.14,
            child: IconButton(
              icon: SvgPicture.asset(
                _isFlashOn ? 'assets/icons/flash_on.svg' : 'assets/icons/flash_off.svg',
              ),
              onPressed: _toggleFlash,
            ),
          ),
          // 카메라 전환 버튼
          Positioned(
            right: size.width * 0.06,
            bottom: size.height * 0.14,
            child: IconButton(
              icon: SvgPicture.asset('assets/icons/refresh.svg') ,
              onPressed: _switchCamera,
            ),
          ),
          // 사진 촬영 버튼
          Positioned(
            bottom: size.height * 0.05,
            left: 0,
            right: 0,
            child: Center(
              child: InkWell(
                onTap: () async {
                  await _takePicture();
                },
                customBorder: CircleBorder(),
                child: Container(
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                  decoration: BoxDecoration(
                    color: Color(0xff3F3F3F),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 10),
                  ),
                ),
              ),
            ),
          ),
          // 갤러리에서 사진 가져오기 버튼
          Positioned(
            left: size.width * 0.07,
            bottom: size.height * 0.05,
            child: GestureDetector(
              onTap: _pickImageFromGallery,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffCDCDCD),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: size.width * 0.13,
                height: size.width * 0.13,
                child: _galleryImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _galleryImage!,
                    fit: BoxFit.cover,
                  ),
                )
                    : Icon(Icons.photo, color: Colors.black),
              ),
            ),
          ),
          // 뒤로가기 버튼
          Positioned(
            top: size.height * 0.02,
            left: size.width * 0.02,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}