import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:signature_match/controller/add_signature_page_ctrl.dart';

class AddSignaturePage extends StatelessWidget {
  const AddSignaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddSignaturePageCtrl());

    AddSignaturePageCtrl ctrl = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Signature"),
      ),
      body: Column(
        children: <Widget>[
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
                Obx(
                  () => ctrl.isDrawing.value
                      ? Container()
                      : Text(
                          "Draw your Signature here!",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade300,
                              fontWeight: FontWeight.bold),
                        ),
                ),
                Signature(
                  color: ctrl.color,
                  strokeWidth: ctrl.strokeWidth,
                  key: ctrl.sign,
                  onSign: () {
                    if (!ctrl.isDrawing.value) ctrl.isDrawing.value = true;
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
                onPressed: () => ctrl.saveSignature(context, ctrl),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.greenAccent),
                ),
                child: const Text("Save"),
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
