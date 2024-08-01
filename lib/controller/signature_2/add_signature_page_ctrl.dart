import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:signature/signature.dart';
import 'package:signature_match/constants/get_storage_keys.dart';
import 'package:signature_match/constants/my_point.dart';

class AddSignaturePageCtrl1 extends GetxController {
  late SignatureController signCtrl = SignatureController(
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.grey.shade400,
    onDrawStart: onDrawStart,
    onDrawMove: onDrawMove,
    onDrawEnd: onDrawEnd,
  );
  RxBool isDrawing = false.obs;

  onDrawStart() {
    isDrawing.value = true;
  }

  onDrawMove() {}

  onDrawEnd() {}

  void clearSign() {
    signCtrl.clear();
    isDrawing.value = false;
  }

  void saveSign() async {
    List<Point> points = signCtrl.points;
    Uint8List? exportedPngBytes = await signCtrl.toPngBytes();

    // if(points.isEmpty || points.length < )

    // Creating a List of encoded JSON strings from `points`.
    List<String> myPointStrings = points
        .map(
          (point) => jsonEncode(
            // Before encoding [Point] to a JSON string, converting it to [MyPoint].
            // Because [Point] doesn't have (toJson) and (fromJson) method.
            MyPoint(point.offset, point.type, point.pressure).toJson(),
          ),
        )
        .toList();

    // Encoding `myPointStrings` to a JSON string and `exportedPngBytes` to string.
    String myPointStringsString = jsonEncode(myPointStrings);
    String encodedPngBytes = base64.encode(exportedPngBytes!.toList());

    // Storing `myPointsStringsString` and `encodedPngBytes` to GetStorage.
    GetStorage().write(GetStorageKeys.pointsString, myPointStringsString);
    GetStorage().write(GetStorageKeys.encodedPngBytes, encodedPngBytes);
  }

  void retriveSignPoints() {
    List<Point> points = [];
    // Retrieving `myPointStringsString` stored in GetStorage.
    String myPointStringsString =
        GetStorage().read(GetStorageKeys.pointsString) ?? "";

    // Decoding `myPointStrings` to a List of [dynamic]s.
    List<dynamic> myPointStrings = jsonDecode(myPointStringsString);

    for (String myPointString in myPointStrings) {
      // After decoding `myPointString` to a JSON object, converting it to [MyPoint].
      MyPoint myPoint = MyPoint.fromJson(jsonDecode(myPointString));
      // Converting [MyPoint] into [Point] for acceptance as parameter.
      Point point = Point(myPoint.offset, myPoint.type, myPoint.pressure);

      // Adding `point` to `points`.
      points.add(point);
    }

    onDrawStart();
    signCtrl.points = points;
  }
}
