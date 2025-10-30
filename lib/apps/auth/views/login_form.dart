import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:titiknol/pkg/const/object_name.dart' as const_object_name;
import 'package:titiknol/pkg/const/labels.dart' as const_labels;
import 'package:titiknol/pkg/views/loading_overlay/loading_overlay.dart';

import 'package:titiknol/pkg/const/assets.dart' as const_assets;
import 'package:titiknol/apps/auth/viewmodels/login.dart';
import 'package:titiknol/apps/auth/views/otp.dart';
import 'package:titiknol/pkg/views/main_container/main_container.dart';

const double sizeBoxForLoginWithGoogle = 5;
const double sizeBoxHeightDistanceEachButton = 0;
const double sizeBoxHeightDistanceEachEdtText = 16;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final LoginViewModel viewModels = Get.put(LoginViewModel());
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    ever(viewModels.isGetOTP, (val) {
      if (val == true) {
        viewModels.isGetOTP(false);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showOtpModal(context, viewModels.token.value);
        });
      }
    });

    ever(viewModels.isLoading, (bool isLoading) {
      if (isLoading) {
        LoadingOverlay.of(context).show(message: const_labels.textWaitingLogin);
      } else {
        LoadingOverlay.of(context).hide();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.sizeOf(context).width;

    var edtTextEmail = FormBuilderTextField(
        name: const_object_name.edtTextEmail,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.black,
          labelText: const_labels.textEmail,
          border: OutlineInputBorder(),
          labelStyle:
              TextStyle(color: Colors.white70), // warna label agar terlihat
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.email(),
        ]));

    var btnLogin = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B4F3B),
        ),
        onPressed: () {
          if (_formKey.currentState?.saveAndValidate() ?? false) {
            FocusScope.of(context).unfocus();
            viewModels.login(_formKey.currentState!.value);
          }
        },
        child: const Text(
          const_labels.buttonLogin,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: MainContainer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      const_assets
                          .imageLoginForm, // Ganti dengan path gambar kamu
                      height: 250,
                      width: widthScreen,
                    ),
                    edtTextEmail,
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
