import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:get/get.dart';
import 'package:health_care_ml_app/ml_kit/translate_util.dart';

import '../controller/ml_text_controller.dart';


class PosePainter extends CustomPainter {
  PosePainter(
    this.poses,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final List<Pose> poses;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final countCt = Get.put(GetCounter());

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.green;

    final leftPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.yellow;

    final paint3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.blue;

    final rightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    for(final pose in poses){
      pose.landmarks.forEach((key, value) {});
      paintLine(PoseLandmarkType type1,PoseLandmarkType type2,Paint paintType){
        final PoseLandmark joint1 = pose.landmarks[type1]!; //land marks는 map형태라 키값접근
        final PoseLandmark  joint2 = pose.landmarks[type2]!;
        canvas.drawLine(
            Offset(
            translateX(joint1.x, size, imageSize, rotation, cameraLensDirection),
            translateY(joint1.y, size, imageSize, rotation, cameraLensDirection),),
        Offset(
        translateX(joint2.x, size, imageSize, rotation, cameraLensDirection),
        translateY(joint2.y, size, imageSize, rotation, cameraLensDirection),),paintType);
      }
      paintLine(
        PoseLandmarkType.rightShoulder,
        PoseLandmarkType.rightHip,
        rightPaint,
      );
      paintLine(
        PoseLandmarkType.leftShoulder,
        PoseLandmarkType.leftHip,
        leftPaint,
      );
      paintLine(
        PoseLandmarkType.leftHip,
        PoseLandmarkType.leftKnee,
        leftPaint,
      );paintLine(
        PoseLandmarkType.leftKnee,
        PoseLandmarkType.leftAnkle,
        leftPaint,
      );
      paintLine(
        PoseLandmarkType.rightHip,
        PoseLandmarkType.rightKnee,
        rightPaint,
      );
      paintLine(
        PoseLandmarkType.rightKnee,
        PoseLandmarkType.rightAnkle,
        rightPaint,
      );
      paintLine(
        PoseLandmarkType.rightHip,
        PoseLandmarkType.leftHip,
        paint3,
      );
      paintLine(
        PoseLandmarkType.rightHip,
        PoseLandmarkType.rightShoulder,
        paint3,
      );
      paintLine(
        PoseLandmarkType.rightShoulder,
        PoseLandmarkType.rightElbow,
        paint3,
      );
      paintLine(
        PoseLandmarkType.leftHip,
        PoseLandmarkType.leftShoulder,
        rightPaint,
      );
      paintLine(
        PoseLandmarkType.leftShoulder,
        PoseLandmarkType.leftElbow,
        rightPaint,
      );

      //무릎의 각도
      var angleKnee = calculateAngel(pose, PoseLandmarkType.rightHip,  PoseLandmarkType.rightKnee,  PoseLandmarkType.rightAnkle);
      //엉덩이의 각도
      var angleHip = calculateAngel(pose, PoseLandmarkType.rightShoulder,  PoseLandmarkType.rightHip,  PoseLandmarkType.rightHip);
      //반대편의 각도
      var kneeAngle = 180 - angleKnee;


      final Paint background = Paint()..color = Colors.black;
      final Paint countFont = Paint()..color = Colors.black.withOpacity(0.5);
      final builder = ParagraphBuilder(ParagraphStyle(textAlign: TextAlign.left,fontSize: 20,textDirection: TextDirection.ltr),
      );
      final hipTextBuilder = ParagraphBuilder(ParagraphStyle(textAlign: TextAlign.left,fontSize: 20,textDirection: TextDirection.ltr),
      );
      final countTextSet = ParagraphBuilder(ParagraphStyle(textAlign: TextAlign.left,fontSize: 40,textDirection: TextDirection.ltr),
      );

    builder.pushStyle(ui.TextStyle(color: Colors.white,background: background));
    builder.addText(kneeAngle.abs().toStringAsFixed(1));
    builder.pop();


      hipTextBuilder.pushStyle(ui.TextStyle(color: Colors.white,background: background));
      hipTextBuilder.addText(angleHip.toStringAsFixed(1));
      hipTextBuilder.pop();
      //올바른 무릎 각도 + 엉덩이 각도에 의한 횟수 카운터
      countCt.upCount(angleKnee, angleHip);

      countTextSet.pushStyle(ui.TextStyle(color: Colors.white,background: countFont));
      countTextSet.addText('${countCt.count.value}');
      countTextSet.pop();

    final rkJoint = pose.landmarks[PoseLandmarkType.rightKnee]!;
    final rhJoint = pose.landmarks[PoseLandmarkType.rightHip]!;
    var textOffset = Offset(
      translateX(rkJoint.x, size, imageSize, rotation, cameraLensDirection),
      translateY(rkJoint.y, size, imageSize, rotation, cameraLensDirection),);


    //텍스트 표시
    canvas.drawParagraph(builder.build()..layout(const ParagraphConstraints(width: 100)), textOffset);

    textOffset = Offset(
        translateX(rhJoint.x, size, imageSize, rotation, cameraLensDirection),
        translateY(rhJoint.y, size, imageSize, rotation, cameraLensDirection),);
      //텍스트 표시
      canvas.drawParagraph(hipTextBuilder.build()..layout(const ParagraphConstraints(width: 100)), textOffset);


      textOffset = Offset(
        translateX(40, size, imageSize, rotation, cameraLensDirection),
        translateY(100, size, imageSize, rotation, cameraLensDirection),);
      //텍스트 표시
      canvas.drawParagraph(countTextSet.build()..layout(const ParagraphConstraints(width: 100)), textOffset);
    }

  }

  double calculateAngel(pose , a , b ,c){
    final PoseLandmark joint1 = pose.landmarks[a];//값을 구하기 위한 변수세개
    final PoseLandmark joint2 = pose.landmarks[b];
    final PoseLandmark joint3 = pose.landmarks[c];

    var radians = atan2(joint3.y - joint2.y, joint3.x - joint2.x) - atan2(joint1.y - joint2.y, joint1.x - joint2.x);

    //radian -> angle
    var angle = (radians * 180.0 / pi).abs();

    if(angle > 180){
      angle - 360 - angle;
    }
    return angle;
  }
  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.poses != poses;
  }
}

