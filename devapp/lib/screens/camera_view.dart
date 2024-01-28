// import 'dart:async';
// import 'dart:io';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:image/image.dart' as img;

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:devapp/main.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:flutter_tflite/flutter_tflite.dart';
// import 'package:devapp/controller/scan_controller.dart';

// class CameraView extends StatelessWidget {
//   const CameraView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GetBuilder<ScanController>(
//       init: ScanController(),
//       builder: (controller) {
//         return controller.isCameraInitialized.value
//             ? CameraPreview(controller.cameraController)
//             : Text("Loading Preview");
//       },
//     ));
//   }
// }
