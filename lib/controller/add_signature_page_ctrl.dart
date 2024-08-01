import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:signature_match/constants/get_storage_keys.dart';

class AddSignaturePageCtrl extends GetxController {
  final sign = GlobalKey<SignatureState>();
  ByteData? imgByteData = ByteData(0);

  Color color = Colors.purple.shade400;
  double strokeWidth = 5.0;

  RxBool isDrawing = false.obs;

  void clearSignature(AddSignaturePageCtrl ctrl) {
    final sign = ctrl.sign.currentState;
    sign!.clear();

    imgByteData = ByteData(0);
    ctrl.isDrawing.value = false;
  }

  void saveSignature(BuildContext context, AddSignaturePageCtrl ctrl) async {
    if (!isDrawing.value) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Draw a Signature to save."),
          ),
        );
      }
      return;
    }

    final sign = ctrl.sign.currentState;
    final img = await sign!.getData();

    imgByteData = await img.toByteData(format: ui.ImageByteFormat.png);

    final encodedImage = base64.encode(imgByteData!.buffer.asUint8List());

    sign.clear();
    isDrawing.value = false;

    GetStorage().write(GetStorageKeys.encodedPngBytes, encodedImage);

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
  }
}
