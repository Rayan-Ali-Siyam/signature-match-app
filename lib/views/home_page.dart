import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:signature_match/constants/get_storage_keys.dart';
import 'package:signature_match/views/add_signature_page.dart';
import 'package:signature_match/views/match_signature_page.dart';
import 'package:signature_match/views/signature_2/add_signature_page.dart';
import 'package:signature_match/views/signature_2/match_signature_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signature Match"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Get.to(const AddSignaturePage1()),
              child: const Text("Add Signature"),
            ),
            ElevatedButton(
              onPressed: () {
                GetStorage().hasData(GetStorageKeys.pointsString)
                    ? Get.to(const MatchSignaturePage1())
                    : ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Add a Signature first!'),
                        ),
                      );
              },
              child: const Text("Match Signature"),
            ),
          ],
        ),
      ),
    );
  }
}
