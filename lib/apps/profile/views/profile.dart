import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import 'package:titiknol/apps/profile/views/user_barcode.dart';
import 'package:titiknol/apps/profile/viewmodels/profile.dart';
import 'package:titiknol/pkg/views/main_container/main_container.dart';
import 'package:titiknol/pkg/app_config.dart';
import 'package:titiknol/pkg/const/keys.dart' as const_keys;
import 'package:titiknol/pkg/const/labels.dart' as const_labels;
import 'package:titiknol/pkg/storage/secure_storage_helper.dart';
import 'package:titiknol/pkg/widget/menu_item.dart';
import 'package:titiknol/pkg/globals/globals.dart' as globals;

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewModel = Get.put(ProfileViewModel());

    void logout() {
      final prefs = FlutterSecureStorageHelper();
      prefs.remove(const_keys.jwtToken);
      AppConfig.user!.jwtToken = null;
      Get.offAllNamed("/login");
    }

    return Scaffold(
      body: MainContainer(
        child: Obx(
          () => profileViewModel.user.value == null
              ? const Center(
                  child: Text("Task Screen"),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    profileViewModel.fetchUser();
                  },
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody:
                            false, // ⬅️ Kunci agar tidak scroll jika konten pendek
                        child: Column(
                          children: [
                            const SizedBox(height: 32),

                            // 🔹 FOTO PROFIL + EMBLEM
                            Center(
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.grey.shade300,
                                    backgroundImage: profileViewModel.user.value
                                                ?.profilePhoto?.isNotEmpty ==
                                            true
                                        ? CachedNetworkImageProvider(
                                            profileViewModel
                                                .user.value!.profilePhoto!,
                                          )
                                        : null,
                                    child: profileViewModel.user.value
                                                ?.profilePhoto?.isEmpty !=
                                            false
                                        ? const Icon(Icons.person,
                                            size: 60, color: Colors.black54)
                                        : null,
                                  ),
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

                            Text(
                              "${profileViewModel.user.value!.firstName} ${profileViewModel.user.value!.lastName}"
                                  .trim(),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 32),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  MenuItem(
                                    icon: Icons.qr_code,
                                    text: const_labels.buttonProfileQRCode,
                                    onTap: () => Get.to(
                                        () => const UserBarcode(),
                                        arguments:
                                            profileViewModel.user.value!.id),
                                  ),
                                  const Divider(height: 1),
                                  MenuItem(
                                    icon: Icons.logout,
                                    text: const_labels.buttonLogout,
                                    onTap: () => logout(),
                                    textColor: Colors.redAccent,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            Text(
                              "Version: ${AppConfig.version ?? '-'}",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
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
