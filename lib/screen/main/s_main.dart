import 'package:fast_app_base/screen/main/todo/s_edit_todo.dart';
import 'package:flutter/material.dart';

import '../../common/common.dart';
import 'home/f_home.dart';
import 'w_menu_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  final List<GlobalKey<NavigatorState>> navigatorKeys = [];

  bool get extendBody => true;

  static double get bottomNavigationBarBorderRadius => 30.0;

  bool isRootPage = true;

  @override
  void initState() {
    super.initState();
    // initNavigatorKeys();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isRootPage,
      onPopInvoked: _handleBackPressed,
      child: Scaffold(
        extendBody: extendBody,
        appBar: AppBar(
          title: "Today's To Do".text.bold.size(25).make(),
          actions: [
            IconButton(
                onPressed: () {
                  Nav.push(EditTodo());
                },
                icon: Icon(Icons.add))
          ],
        ), //bottomNavigationBar 아래 영역 까지 그림
        //drawer: const MenuDrawer(),
        body: SafeArea(
          bottom: !extendBody,
          child: HomeFragment(),
        ),
        // bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  void _handleBackPressed(bool didPop) {}

// Widget _buildBottomNavigationBar(BuildContext context) {
//   return Container(
//     decoration: const BoxDecoration(
//       boxShadow: [
//         BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
//       ],
//     ),
//     child: ClipRRect(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(bottomNavigationBarBorderRadius),
//         topRight: Radius.circular(bottomNavigationBarBorderRadius),
//       ),
//       child: BottomNavigationBar(
//         items: navigationBarItems(context),
//         currentIndex: _currentIndex,
//         selectedItemColor: context.appColors.text,
//         unselectedItemColor: context.appColors.iconButtonInactivate,
//         onTap: _handleOnTapNavigationBarItem,
//         showSelectedLabels: true,
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//       ),
//     ),
//   );
// }
//
// List<BottomNavigationBarItem> navigationBarItems(BuildContext context) {
//   return tabs
//       .mapIndexed(
//         (tab, index) => tab.toNavigationBarItem(
//           context,
//           isActivated: _currentIndex == index,
//         ),
//       )
//       .toList();
// }
//
// void _changeTab(int index) {
//   setState(() {
//     _currentTab = tabs[index];
//   });
// }
//
// BottomNavigationBarItem bottomItem(bool activate, IconData iconData, IconData inActivateIconData, String label) {
//   return BottomNavigationBarItem(
//       icon: Icon(
//         key: ValueKey(label),
//         activate ? iconData : inActivateIconData,
//         color: activate ? context.appColors.iconButton : context.appColors.iconButtonInactivate,
//       ),
//       label: label);
// }
//
// void _handleOnTapNavigationBarItem(int index) {
//   final oldTab = _currentTab;
//   final targetTab = tabs[index];
//   if (oldTab == targetTab) {
//     final navigationKey = _currentTabNavigationKey;
//     popAllHistory(navigationKey);
//   }
//   _changeTab(index);
// }

  void popAllHistory(GlobalKey<NavigatorState> navigationKey) {
    final bool canPop = navigationKey.currentState?.canPop() == true;
    if (canPop) {
      while (navigationKey.currentState?.canPop() == true) {
        navigationKey.currentState!.pop();
      }
    }
  }

// void initNavigatorKeys() {
//   for (final _ in tabs) {
//     navigatorKeys.add(GlobalKey<NavigatorState>());
//   }
// }
}
