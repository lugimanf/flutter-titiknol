import 'package:flutter/material.dart';
import 'package:titiknol/pkg/views/main_container/main_container.dart';
import 'package:get/get.dart';
import 'package:titiknol/pkg/const/assets.dart' as const_assets;
import 'package:titiknol/pkg/const/keys.dart' as const_keys;
import 'package:titiknol/pkg/const/labels.dart' as const_labels;
import 'package:titiknol/pkg/storage/secure_storage_helper.dart';
import 'package:titiknol/pkg/app_config.dart';
import 'package:titiknol/pkg/widget/menu_item.dart';
import 'package:titiknol/pkg/globals/globals.dart' as globals;

class Profile extends StatelessWidget {
  final String? userImageUrl =
      "https://eeduczjtkdtfhlsuhgan.supabase.co/storage/v1/object/public/images/pp_200_200.png";
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() {
      final prefs = FlutterSecureStorageHelper();
      prefs.remove(const_keys.jwtToken);
      AppConfig.user!.jwtToken = null;
      Get.offAllNamed("/login");
    }

    return Scaffold(
      body: MainContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),

              /// 🔹 FOTO PROFIL + EMBLEM
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    // 🧑 Foto user (atau icon default)
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage:
                          userImageUrl != null && userImageUrl!.isNotEmpty
                              ? NetworkImage(userImageUrl!)
                              : null,
                      child: userImageUrl == null || userImageUrl!.isEmpty
                          ? const Icon(Icons.person,
                              size: 60, color: Colors.black54)
                          : null,
                    ),

                    // 🏅 Emblem rank nempel di bawah kanan
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: ClipOval(
                        child: Container(
                          width: 32,
                          height: 32,
                          color: Colors.white,
                          padding: const EdgeInsets.all(3),
                          child: Image.asset(
                            globals.medalAsset[0],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              /// 🔹 Nama User
              Text(
                "Ganteng",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 32),

              /// 🔹 Menu seperti daftar (bukan tombol besar)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    MenuItem(
                      icon: Icons.qr_code,
                      text: "Show QR Code",
                      onTap: () => Get.toNamed('/showQRCode'),
                    ),
                    const Divider(height: 1),
                    MenuItem(
                      icon: Icons.logout,
                      text: "Logout",
                      onTap: () => logout(),
                      textColor: Colors.redAccent,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// 🔹 Versi aplikasi
              Text(
                "Version: ${AppConfig.version ?? '-'}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
