import 'package:flutter/material.dart';

import 'package:titiknol/pkg/const/assets.dart' as const_assets;
import 'package:titiknol/apps/auth/views/login_form.dart';
import 'package:titiknol/apps/auth/views/register_form.dart';

const double sizeBoxForLoginWithGoogle = 5;
const double sizeBoxHeightDistanceEachButton = 7;
const double sizeBoxHeightDistanceEachEdtText = 16;

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.sizeOf(context).height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(
              top: heightScreen * 0.03, bottom: 0, left: 0, right: 0),
          child: SafeArea(
            child: Column(
              children: [
                // Gambar di atas
                Image.asset(
                  const_assets.imageLoginForm, // Ganti dengan path gambar kamu
                  height: 300,
                ),
                // TabBar di tengah
                const TabBar(
                  tabs: [
                    Tab(text: 'Login'),
                    Tab(text: 'Register'),
                  ],
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                ),

                // Konten Login & Register
                const Expanded(
                  child: TabBarView(
                    children: [
                      LoginForm(),
                      RegisterForm(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
