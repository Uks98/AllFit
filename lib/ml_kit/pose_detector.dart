import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:health_care_ml_app/ml_kit/pose_painter.dart';
import 'package:image_picker/image_picker.dart';

import 'camera_view_page.dart';
import 'dummy.dart';

class FaceDetectorApp extends StatefulWidget {
  const FaceDetectorApp({super.key});

  @override
  State<FaceDetectorApp> createState() => _FaceDetectorAppState();
}

class _FaceDetectorAppState extends State<FaceDetectorApp> {
  File? _image;
  ImagePicker imagePicker = ImagePicker();
  String? resultText;
  final count_ct = Get.put(GetCounter());
  final PoseDetector poseDetector = PoseDetector(
      options: PoseDetectorOptions(
          mode: PoseDetectionMode.stream, model: PoseDetectionModel.base));

  CustomPaint? customPaint;

  @override
  void dispose() {
    poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI 운동 가이드"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: CameraView(
        customPaint: customPaint,
        onImage: _processImage,
      ),

      // Obx(() => Text(count_ct.count.value.toString()))
    );
  }

  Future _getImage(ImageSource source) async {
    setState(() {
      _image = null;
    });
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      _processFile(pickedFile.path);
    }
  }

  Future _processFile(String path) async {
    setState(() {
      _image = File(path);
    });
    final inputImage = InputImage.fromFilePath(path);
    _processImage(inputImage);
  }

  Future<void> _processImage(InputImage inputImage) async {
    setState(() {
      resultText = '';
    });
    final poses = await poseDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = PosePainter(poses, inputImage.metadata!.size,
          inputImage.metadata!.rotation, CameraLensDirection.back);
      setState(() {
        customPaint = CustomPaint(painter: painter);
      });
    } else {
      resultText = resultText = 'Poses 몇개? ${poses.length}';
      setState(() {});
    }
  }
}
