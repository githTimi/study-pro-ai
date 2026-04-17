import 'package:flutter/material.dart';
import 'package:study_pro/feautures/home/home_page.dart';
import 'package:study_pro/feautures/home/libary.dart';
import 'package:study_pro/feautures/home/profile.dart';

class MainNavPage extends StatefulWidget {
  const MainNavPage({super.key});

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  int currentIndex = 0;

  final List<Widget> pages = const [HomePage(), LibraryPage(), ProfilePage()];

  double navIconSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return 24;
    if (width < 1024) return 28;
    return 32;
  }

  double navFontSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return 12;
    if (width < 1024) return 14;
    return 16;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF842CD3),
        unselectedItemColor: const Color(0xFF9A95A8),
        selectedFontSize: navFontSize(context),
        unselectedFontSize: navFontSize(context),
        iconSize: navIconSize(context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
