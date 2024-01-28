// import 'package:camera/camera.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:get/get.dart';

// class ScanController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();
//     initCamera();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     cameraController.dispose();
//   }

//   late CameraController cameraController;
//   late List<CameraDescription> cameras;

//   late CameraImage cameraImage;

//   var isCameraInitialized = false.obs;
//   var cameraCount = 0;

//   initCamera() async {
//     if (await Permission.camera.request().isGranted) {
//       cameras = await availableCameras();

//       cameraController = CameraController(cameras[0], ResolutionPreset.medium);
//       await cameraController.initialize();
//       isCameraInitialized(true);
//     } else {
//       print("Permission denied");
//     }
//   }
// }
