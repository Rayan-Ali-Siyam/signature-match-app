import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:signature_match/controller/signature_2/add_signature_page_ctrl.dart';

class AddSignaturePage1 extends StatelessWidget {
  const AddSignaturePage1({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddSignaturePageCtrl1());

    AddSignaturePageCtrl1 ctrl = Get.find();
    ctrl.retriveSignPoints();

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
                onPressed: () => ctrl.saveSign(),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.greenAccent),
                ),
                child: const Text("Save"),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => ctrl.retriveSignPoints(),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text("Retrive"),
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
