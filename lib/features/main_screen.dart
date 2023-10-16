import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.navigationShell}) : super(key: key);

  final StatefulNavigationShell navigationShell;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.navigationShell.currentIndex,
        onTap: _onTap,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        // unselectedItemColor: AppColors.gray60Default,
        // selectedItemColor: AppColors.primaryGreenNormal,
        // unselectedLabelStyle:
        //     AppTextTheme(fontLanguage: FontLanguage.en).regularSBodyText.copyWith(color: AppColors.gray60Default),
        // selectedLabelStyle:
        //     AppTextTheme(fontLanguage: FontLanguage.en).regularSBodyText.copyWith(color: AppColors.primaryGreenNormal),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              widget.navigationShell.currentIndex == 0 ? Icons.home : Icons.home_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              widget.navigationShell.currentIndex == 1 ? Icons.chat_bubble : Icons.chat_bubble_outlined,
            ),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              widget.navigationShell.currentIndex == 2 ? Icons.settings : Icons.settings_outlined,
            ),
            label: 'setting',
          ),
        ],
      ),
      body: widget.navigationShell,
    );
  }

  /// The callback function for when a bottom navigation bar item is tapped.
  void _onTap(index) {
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
    // and reload the destination page
  }
}
