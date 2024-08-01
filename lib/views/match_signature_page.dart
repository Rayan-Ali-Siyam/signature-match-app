import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:get/get.dart';
import 'package:signature_match/controller/match_signature_page_ctrl.dart';

class MatchSignaturePage extends StatelessWidget {
  const MatchSignaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MatchSignaturePageCtrl());

    MatchSignaturePageCtrl ctrl = Get.find();
    ctrl.retriveSignature();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Match Signature"),
      ),
      body: Column(
        children: [
          const Spacer(flex: 3),
          Container(
            height: Get.size.height * .35,
            width: Get.size.width * .9,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.saturation,
                    ),
                    child: Image.memory(
                      ctrl.savedImgByteData.buffer.asUint8List(),
                    ),
                  ),
                ),
                Signature(
                  color: ctrl.color,
                  strokeWidth: ctrl.strokeWidth,
                  key: ctrl.sign,
                  onSign: () {
                    // if (!ctrl.isDrawing.value) ctrl.isDrawing.value = true;
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              ElevatedButton(
                onPressed: () => ctrl.matchSignature(context, ctrl),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.greenAccent),
                ),
                child: const Text("Match"),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => ctrl.clearSignature(ctrl),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent),
                ),
                child: const Text("Clear"),
              ),
              const Spacer(flex: 2),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
