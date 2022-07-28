import 'package:flutter/material.dart';
import 'screens/feed_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class BottomNavBarState extends StatefulWidget {
  @override
  _BottomNavBarStateState createState() => _BottomNavBarStateState();
}

class _BottomNavBarStateState extends State<BottomNavBarState> {

  PersistentTabController _controller = PersistentTabController(initialIndex: 0);

//Screens for each nav items.
  List<Widget> _navScreens() {
    return [
      FeedScreen(),
      ProfileScreen(),
      SettingsScreen(),
    ];
  }


  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.apps),//ImageIcon(AssetImage('assets/images/feed.png'),size: 40),
        title: (""),
        inactiveColorPrimary: Color(0xFF000000),
        activeColorPrimary: Color(0xFF6C6C6C),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_circle),//ImageIcon(AssetImage('assets/images/profile.png'),size: 55),
        title: (""),
        inactiveColorPrimary: Color(0xFF000000),
        activeColorPrimary: Color(0xFF6C6C6C),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),//ImageIcon(AssetImage('assets/images/settings.png'),size: 40),
        title: (""),
        inactiveColorPrimary: Color(0xFF000000),
        activeColorPrimary: Color(0xFF6C6C6C),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _navScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color(0xFFDBDBDB),
      handleAndroidBackButtonPress: true,
      //resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      navBarStyle: NavBarStyle.style12,
    );
  }
}
