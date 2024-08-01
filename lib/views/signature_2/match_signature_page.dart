import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:signature_match/controller/signature_2/match_signature_page_ctrl.dart';

class MatchSignaturePage1 extends StatelessWidget {
  const MatchSignaturePage1({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MatchSignaturePageCtrl1());

    MatchSignaturePageCtrl1 ctrl = Get.find();
    ctrl.retrieveSign();

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
            clipBehavior: Clip.antiAlias,
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
                Image.memory(
                  ctrl.exportedPngBytes,
                ),
                Signature(
                  controller: ctrl.signCtrl,
                  backgroundColor: Colors.transparent,
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
                onPressed: () => ctrl.matchSign(context),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.greenAccent),
                ),
                child: const Text("Match"),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => ctrl.clearSign(),
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
