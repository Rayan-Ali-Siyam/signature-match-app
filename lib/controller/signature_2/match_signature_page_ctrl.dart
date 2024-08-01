import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_compare/image_compare.dart';
import 'package:signature/signature.dart';
import 'package:signature_match/constants/get_storage_keys.dart';
import 'package:signature_match/constants/my_point.dart';

class MatchSignaturePageCtrl1 extends GetxController {
  late SignatureController signCtrl = SignatureController(
    penColor: Colors.purple.shade300,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.grey.shade400,
    onDrawStart: onDrawStart,
    onDrawMove: onDrawMove,
    onDrawEnd: onDrawEnd,
  );
  late Uint8List exportedPngBytes;
  List<Point> exportedPoints = [];

  onDrawStart() {}

  onDrawMove() {}

  onDrawEnd() {}

  void clearSign() {
    signCtrl.clear();
  }

  retrieveSign() {
    // Retrieving `myPointStringsString` and `encodedPngBytes` stored in GetStorage.
    String myPointStringsString =
        GetStorage().read(GetStorageKeys.pointsString) ?? "";
    String encodedPngBytes = GetStorage().read(GetStorageKeys.encodedPngBytes);

    // Decoding `myPointStrings` to a List<dynamic> and `encodedPngBytes` to [Uint8List].
    List<dynamic> myPointStrings = jsonDecode(myPointStringsString);
    exportedPngBytes = base64.decode(encodedPngBytes);

    for (String myPointString in myPointStrings) {
      // After decoding `myPointString` to a JSON object, converting it to [MyPoint].
      MyPoint myPoint = MyPoint.fromJson(jsonDecode(myPointString));
      // Converting [MyPoint] into [Point] for acceptance as parameter.
      Point point = Point(myPoint.offset, myPoint.type, myPoint.pressure);

      // Adding `point` to `exportedPoints`.
      exportedPoints.add(point);
    }
    debugPrint("Points Length: ${exportedPoints.length.toString()}");
  }

  matchSign(BuildContext context) async {
    Uint8List? pngBytes = await signCtrl.toPngBytes();

    double similarity = await compareImages(
      src1: exportedPngBytes,
      src2: pngBytes,
      algorithm: PixelMatching(
        ignoreAlpha: true,
      ),
    );

    if ((similarity * 100) < 15) {
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

    print('${(similarity * 100).toStringAsFixed(2)}%');
  }
}
