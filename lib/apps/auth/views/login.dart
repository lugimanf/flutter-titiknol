import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:titiknol/apps/auth/viewmodels/login.dart';
import 'package:titiknol/pkg/const/object_name.dart' as const_object_name;
import 'package:titiknol/pkg/const/assets.dart' as const_assets;
import 'package:titiknol/pkg/const/labels.dart' as const_labels;
import 'package:titiknol/pkg/const/fonts.dart' as const_fonts;
import 'package:titiknol/pkg/views/loading_overlay/loading_overlay.dart';

const double sizeBoxForLoginWithGoogle = 5;
const double sizeBoxHeightDistanceEachButton = 7;
const double sizeBoxHeightDistanceEachEdtText = 16;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final LoginViewModel viewModels = Get.put(LoginViewModel());
    double heightScreen = MediaQuery.sizeOf(context).height;

    var edtTextUsername = FormBuilderTextField(
        name: const_object_name.edtTextUsername,
        decoration: const InputDecoration(
          labelText: const_labels.textDataUser,
          border: OutlineInputBorder(),
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          // FormBuilderValidators.email(),
        ]));

    // var btnLoginWithGoogle = SizedBox(
    //   width: double.infinity,
    //   child: ElevatedButton(
    //     onPressed: () {
    //       viewModels.login(_formKey.currentState!.value);
    //     },
    //     child: Row(
    //       mainAxisAlignment:
    //           MainAxisAlignment.center, //Center Row contents horizontally,
    //       crossAxisAlignment:
    //           CrossAxisAlignment.center, //Center Row contents vertically,
    //       children: [
    //         Image.asset(
    //           const_assets.iconGoogleLogo,
    //           height: 20,
    //         ),
    //         const SizedBox(width: sizeBoxForLoginWithGoogle),
    //         const Text(
    //           const_labels.buttonLoginWithGoogle,
    //           style: TextStyle(color: Colors.black),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    var btnLogin = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
        ),
        onPressed: () {
          if (_formKey.currentState?.saveAndValidate() ?? false) {
            FocusScope.of(context).unfocus();
            viewModels.login(_formKey.currentState!.value);
          }
        },
        child: const Text(
          const_labels.buttonLogin,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );

    // Menjalankan fungsi ketika counter.value berubah
    ever(viewModels.isLoading, (bool isLoading) {
      if (isLoading) {
        LoadingOverlay.of(context).show(message: const_labels.textWaitingLogin);
      } else {
        LoadingOverlay.of(context).hide();
      }
    });

    ever(viewModels.messageLogin, (String message) {});

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
            top: heightScreen * 0.07, bottom: 0, left: 0, right: 0),
        child: Column(
          children: [
            Image.asset(
              const_assets.imageLoginForm,
              height: 300,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Dexin Portal",
                style: TextStyle(fontFamily: const_fonts.fontFamilyUsed),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    edtTextUsername,
                    // const SizedBox(height: sizeBoxHeightDistanceEachEdtText),
                    // edtTextPassword,
                    const SizedBox(height: sizeBoxHeightDistanceEachButton),
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                          child: Obx(() => Text(
                                viewModels.messageLogin.value,
                                style: const TextStyle(color: Colors.redAccent),
                              ))),
                    ),
                    const SizedBox(height: sizeBoxHeightDistanceEachButton),
                    btnLogin,
                    // const SizedBox(height: sizeBoxHeightDistanceEachButton),
                    // btnLoginWithGoogle,
                    // const SizedBox(height: sizeBoxHeightDistanceEachButton),
                    // btnRegister,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
