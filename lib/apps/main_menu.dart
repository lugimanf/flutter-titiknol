import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './home/views/home.dart';
import 'profile/views/profile.dart';
import 'voucher/views/voucher.dart';
import 'task/views/task.dart';
import 'package:titiknol/apps/scanner/views/scanner.dart';
import 'package:titiknol/pkg/const/labels.dart' as const_label;

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int currentIndex = 0;
  bool showMiddleButton = true; // ✅ FAB aktif/nonaktif

  final screens = [
    const Home(),
    const Task(),
    const Voucher(),
    const Profile(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildTabItem({
      required IconData icon,
      required String label,
      required int index,
      required bool selected,
      required VoidCallback onTap,
    }) {
      final color = selected ? Colors.amber : Colors.grey;
      return Expanded(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      floatingActionButton: showMiddleButton
          ? FloatingActionButton(
              onPressed: () {
                Get.to(() => const QRISScannerPage());
              },
              shape: const CircleBorder(),
              backgroundColor: Colors.amber,
              child: const Icon(Icons.camera_alt_rounded),
            )
          : null,
      floatingActionButtonLocation:
          showMiddleButton ? FloatingActionButtonLocation.centerDocked : null,
      bottomNavigationBar: BottomAppBar(
        shape: showMiddleButton ? const CircularNotchedRectangle() : null,
        notchMargin: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: showMiddleButton
                ? [
                    buildTabItem(
                      icon: Icons.home,
                      label: const_label.labelHome,
                      index: 0,
                      selected: currentIndex == 0,
                      onTap: () => onTabTapped(0),
                    ),
                    buildTabItem(
                      icon: Icons.assignment,
                      label: const_label.labelTask,
                      index: 1,
                      selected: currentIndex == 1,
                      onTap: () => onTabTapped(1),
                    ),
                    const SizedBox(width: 48),
                    buildTabItem(
                      icon: Icons.airplane_ticket,
                      label: const_label.labelVoucher,
                      index: 2,
                      selected: currentIndex == 2,
                      onTap: () => onTabTapped(2),
                    ),
                    buildTabItem(
                      icon: Icons.person,
                      label: const_label.labelProfile,
                      index: 3,
                      selected: currentIndex == 3,
                      onTap: () => onTabTapped(3),
                    ),
                  ]
                : [
                    buildTabItem(
                      icon: Icons.home,
                      label: const_label.labelHome,
                      index: 0,
                      selected: currentIndex == 0,
                      onTap: () => onTabTapped(0),
                    ),
                    buildTabItem(
                      icon: Icons.assignment,
                      label: const_label.labelTask,
                      index: 1,
                      selected: currentIndex == 1,
                      onTap: () => onTabTapped(1),
                    ),
                    buildTabItem(
                      icon: Icons.card_giftcard,
                      label: const_label.labelVoucher,
                      index: 2,
                      selected: currentIndex == 2,
                      onTap: () => onTabTapped(2),
                    ),
                    buildTabItem(
                      icon: Icons.person,
                      label: const_label.labelProfile,
                      index: 3,
                      selected: currentIndex == 3,
                      onTap: () => onTabTapped(3),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
