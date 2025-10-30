import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:titiknol/pkg/const/fonts.dart' as const_fonts;
import 'package:titiknol/pkg/const/labels.dart' as const_labels;

import 'package:titiknol/apps/auth/viewmodels/login.dart';

class OtpForm extends StatefulWidget {
  final String token; // Tambahkan parameter

  const OtpForm({super.key, required this.token});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final LoginViewModel viewModels = Get.put(LoginViewModel());
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();

    // Fokuskan ke editbox pertama setelah layout selesai
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    final otp = _controllers.map((c) => c.text).join();

    if (otp.length == 4) {
      viewModels.loginConfirmOtp(otp, widget.token);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "sent to email",
                style: TextStyle(fontFamily: const_fonts.fontFamilyUsed),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  width: 80,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _onChanged(index, value),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context); // Menutup modal
              },
              icon: const Icon(Icons.close),
              label: const Text(const_labels.buttonClose),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
            )
          ],
        ));
  }
}

bool _isShowingOtp = false;
void showOtpModal(BuildContext context, String token) {
  if (_isShowingOtp) return; // cegah panggilan berulang
  _isShowingOtp = true;

  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Enter OTP code",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 3),
            OtpForm(token: token),
          ],
        ),
      );
    },
  ).whenComplete(() {
    // Reset flag ketika sheet ditutup
    _isShowingOtp = false;
  });
}
