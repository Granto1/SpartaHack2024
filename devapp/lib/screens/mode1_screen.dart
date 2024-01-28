import 'dart:async';
import 'dart:io';
import 'package:image/image.dart' as img;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:devapp/main.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class ModeScreen extends StatefulWidget {
  @override
  _ModeScreenState createState() => _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> with WidgetsBindingObserver {
  CameraController? controller;
  bool _isCameraInitialized = false;
  CameraImage? _cameraImage;

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
    int _image_count =0;
    // cameraController.startImageStream((image) {
    //     _image_count++;
    //     if (_image_count % 10 == 0)
    //     {
    //       _image_count = 0;
    //       objectRecognition(image);
    //       print("balls");
    //     }
    //      _cameraImage = image;
    // });
  }

  @override
  void initState() {
    onNewCameraSelected(cameras[1]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    Tflite.close();
    super.dispose();
  }

  Future<void> objectRecognition(CameraImage cameraImage) async {
    var recognitions = await Tflite.runModelOnFrame(
        bytesList: cameraImage.planes.map((plane) {
          return plane.bytes;
        }).toList(), // required
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        imageMean: 127.5, // defaults to 127.5
        imageStd: 127.5, // defaults to 127.5
        rotation: 90, // defaults to 90, Android only
        numResults: 2, // defaults to 5
        threshold: 0.1, // defaults to 0.1
        asynch: true // defaults to true
        );
        print(recognitions);
  }

  Future<void> _initTensorFlow() async {
    String? res = await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/labels.txt",
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Text("Practice!",
              style: TextStyle(fontSize: 50, color: Colors.blue)),
        ),
        Container(
          alignment: Alignment.center,
          height: 500,
          child: _isCameraInitialized
              ? AspectRatio(
                  aspectRatio: 1 / controller!.value.aspectRatio,
                  child: controller!.buildPreview(),
                )
              : Container(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          height: 200,
          width: 200,
          child: TextButton(
            // style: ButtonStyle(
            //   foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            // ),
            style: flatButtonStyle,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "BACK!",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.blue,
              ),
            ),
          ),
        )
      ],
    ));
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Container(
    //         height: 500,
    //         width: double.infinity,
    //         color: Colors.black,
    //       ),
    //       Row(
    //         children: [
    //           Container(
    //             height: 200,
    //             width: 200,
    //             child: TextButton(
    //               // style: ButtonStyle(
    //               //   foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    //               // ),
    //               style: flatButtonStyle,
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: const Text(
    //                 "BACK!",
    //                 style: TextStyle(
    //                   fontSize: 60.0,
    //                   color: Colors.blue,
    //                 ),
    //               ),
    //             ),
    //           )
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.blue,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
