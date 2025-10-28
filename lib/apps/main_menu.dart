import 'package:flutter/material.dart';
import './home/views/home.dart';
import './account/views/account.dart';
// import './priviledge/views/priviledge.dart';
import './activity/views/activity.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int currentIndex = 0;
  bool showMiddleButton = false; // ✅ FAB aktif/nonaktif

  final screens = [
    const Home(),
    // const Priviledge(),
    const Activity(),
    const Account(),
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
                debugPrint("FAB Pressed");
              },
              shape: const CircleBorder(),
              backgroundColor: Colors.amber,
              child: const Icon(Icons.add),
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
                      label: "Home",
                      index: 0,
                      selected: currentIndex == 0,
                      onTap: () => onTabTapped(0),
                    ),
                    const SizedBox(width: 48),
                    buildTabItem(
                      icon: Icons.access_time,
                      label: "Activity",
                      index: 1,
                      selected: currentIndex == 1,
                      onTap: () => onTabTapped(1),
                    ),
                    buildTabItem(
                      icon: Icons.person,
                      label: "Profile",
                      index: 2,
                      selected: currentIndex == 2,
                      onTap: () => onTabTapped(2),
                    ),
                  ]
                : [
                    buildTabItem(
                      icon: Icons.home,
                      label: "Home",
                      index: 0,
                      selected: currentIndex == 0,
                      onTap: () => onTabTapped(0),
                    ),
                    buildTabItem(
                      icon: Icons.access_time,
                      label: "Activity",
                      index: 1,
                      selected: currentIndex == 1,
                      onTap: () => onTabTapped(1),
                    ),
                    buildTabItem(
                      icon: Icons.person,
                      label: "Profile",
                      index: 2,
                      selected: currentIndex == 2,
                      onTap: () => onTabTapped(2),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
