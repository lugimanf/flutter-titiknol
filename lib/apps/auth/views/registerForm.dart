import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:titiknol/apps/auth/viewmodels/login.dart';
import 'package:titiknol/pkg/const/object_name.dart' as const_object_name;
import 'package:titiknol/pkg/const/labels.dart' as const_labels;

const double sizeBoxForLoginWithGoogle = 5;
const double sizeBoxHeightDistanceEachButton = 7;
const double sizeBoxHeightDistanceEachEdtText = 16;

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final LoginViewModel viewModels = Get.put(LoginViewModel());
    double heightScreen = MediaQuery.sizeOf(context).height;

    var edtTextFullName = FormBuilderTextField(
        name: const_object_name.edtTextFullName,
        decoration: const InputDecoration(
          labelText: const_labels.textFullname,
          border: OutlineInputBorder(),
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]));

    var edtTextEmail = FormBuilderTextField(
        name: const_object_name.edtTextEmail,
        decoration: const InputDecoration(
          labelText: const_labels.textEmail,
          border: OutlineInputBorder(),
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.email(),
        ]));

    var btnRegister = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
        ),
        onPressed: () {
          Get.offNamed("/register");
        },
        child: const Text(const_labels.buttonRegister,
            style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
            top: heightScreen * 0.03, bottom: 0, left: 0, right: 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    edtTextFullName,
                    const SizedBox(height: sizeBoxHeightDistanceEachEdtText),
                    edtTextEmail,
                    const SizedBox(height: sizeBoxHeightDistanceEachButton),
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                          child: Obx(() => Text(
                                viewModels.messageRegister.value,
                                style: const TextStyle(color: Colors.redAccent),
                              ))),
                    ),
                    const SizedBox(height: sizeBoxHeightDistanceEachButton),
                    btnRegister,
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
