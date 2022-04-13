import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:untitled/presentation/favourite.dart';
import 'package:untitled/presentation/homepage.dart';

class TabView extends StatelessWidget {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  TabView({Key? key}) : super(key: key);

  List<Widget> _buildScreens() {
    return [const HomePage(), const FavouritePage()];
  }

  List<PersistentBottomNavBarItem> _buildItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.news),
          title: "Новости",
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.star),
          title: "Избранное",
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _buildItems(),
      confineInSafeArea: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white
      ),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style9,
    );
  }
}
