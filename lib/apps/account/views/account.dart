import 'package:flutter/material.dart';
import 'package:titiknol/pkg/views/main_container/main_container.dart';
import 'package:get/get.dart';
import 'package:titiknol/pkg/const/assets.dart' as const_assets;
import 'package:titiknol/pkg/const/keys.dart' as const_keys;
import 'package:titiknol/pkg/const/labels.dart' as const_labels;
import 'package:titiknol/pkg/storage/shared_preferences.dart';
import 'package:titiknol/pkg/globals/globals.dart' as globals;

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() {
      final prefs = SharedPreferencesHelper();
      prefs.remove(const_keys.jwtToken);
      globals.token = null;
      Get.offAllNamed("/login");
    }

    return Scaffold(
      body: MainContainer(
        child: SingleChildScrollView(
          child: SizedBox(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.asset(
                const_assets.imageExampleQRCode,
                width: double.infinity,
                alignment: Alignment.center,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () {
                    logout();
                  },
                  child: const Text(const_labels.buttonLogout,
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(
                child: Center(child: Text("version: ${globals.version}")),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
