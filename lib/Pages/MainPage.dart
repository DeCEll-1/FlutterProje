// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import, prefer_final_fields, unused_field, dead_code, unnecessary_null_comparison, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proje/GoogleCrab/GoogleAccountsHelper.dart';
import 'package:proje/Helpers/Misc.dart';
import 'package:proje/Pages/NoteAddingPage.dart';
import 'package:proje/Pages/NoteListPage.dart';
import 'package:proje/main.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PersistentTabController _tabController = PersistentTabController(initialIndex: 0);

  NavBarStyle style = NavBarStyle.style3;

  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  ScrollController _scrollController3 = ScrollController();

  Map<String, Widget Function(BuildContext)>? routers = {
    "/first": (final context) => Container(),
    "/second": (final context) => Container(),
    "/third": (final context) => Container(),
  };

  List<Widget> _buildScreens() {
    return [
      NoteList(),
      NoteAddingPage(),
      Container(
        child: ElevatedButton(
            onPressed: () {
              GoogleAccountsHelper.signOutFromGoogle();
              Misc.MoveAndRemovePast(context, MyHomePage());
            },
            child: Text("Sign Out")),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.note),
        title: ("See Notes"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: _scrollController1,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: routers,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.note_add),
        title: ("New Note"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: _scrollController2,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: routers,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: _scrollController3,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: routers,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(border: BorderDirectional(bottom: BorderSide(width: 2, color: Colors.black))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("App"),
            ],
          ),
        ),
      ),
      body: PersistentTabView(
        context,
        controller: _tabController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
        stateManagement: false, // Default is true.
        hideNavigationBarWhenKeyboardAppears: true,
        popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
        padding: const EdgeInsets.only(top: 8),
        backgroundColor: Colors.grey.shade900,
        isVisible: true,
        animationSettings: const NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            duration: Duration(milliseconds: 200),
            screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
          ),
        ),
        confineToSafeArea: true,
        navBarHeight: kBottomNavigationBarHeight,
        navBarStyle: style, // Choose the nav bar style with this property
      ),
    );
  }
}
