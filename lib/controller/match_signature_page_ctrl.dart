import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_compare/image_compare.dart';
import 'package:signature_match/constants/get_storage_keys.dart';

class MatchSignaturePageCtrl extends GetxController {
  final sign = GlobalKey<SignatureState>();
  late ByteData savedImgByteData;
  ByteData? newImgByteData = ByteData(0);

  Color color = Colors.purple.shade400;
  double strokeWidth = 5.0;

  void retriveSignature() {
    GetStorage box = GetStorage();

    final String encodedImage =
        box.read<String>(GetStorageKeys.encodedPngBytes)!;

    final decodedImage = base64.decode(encodedImage);

    savedImgByteData = decodedImage.buffer.asByteData();
  }

  void clearSignature(MatchSignaturePageCtrl ctrl) {
    final sign = ctrl.sign.currentState;
    sign!.clear();

    newImgByteData = ByteData(0);
  }

  void matchSignature(BuildContext context, MatchSignaturePageCtrl ctrl) async {
    final sign = ctrl.sign.currentState;
    final img = await sign!.getData();

    newImgByteData = await img.toByteData(format: ui.ImageByteFormat.png);

    double result = await compareImages(
        src1: savedImgByteData.buffer.asUint8List(),
        src2: newImgByteData!.buffer.asUint8List());

    if ((result * 100) < 5) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Signature Matched",
              style: TextStyle(color: Colors.green),
            ),
          ),
        );
      }
      Get.back();
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Signature doesn't Matched",
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      }
    }

    print('${(result * 100).toStringAsFixed(2)}%');
  }
}
