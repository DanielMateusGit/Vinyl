
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/material.dart';
import 'package:vinylproject/screens/download.dart';
import 'package:vinylproject/screens/music.dart';
import 'package:vinylproject/screens/poadcast.dart';
import 'package:vinylproject/screens/search.dart';
import 'package:vinylproject/constants.dart';

class NavigationBar extends StatelessWidget {

  // views
  List<Widget> _buildScreens() => [Music(), Podcast(), Search(), Downloads()];

  // navigation controller
  final PersistentTabController _controller  = PersistentTabController(initialIndex: 0);

  // tabs of navigator
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: icons[0],
        iconSize: iconSize,
        title: ("Music"),
        activeColorPrimary: kActivetab,
        inactiveColorPrimary: kUnactivetab,
      ),
      PersistentBottomNavBarItem(
        icon: icons[1],
        iconSize: iconSize,
        title: ("Poadcast"),
        activeColorPrimary: kActivetab,
        inactiveColorPrimary: kUnactivetab,
      ),
      PersistentBottomNavBarItem(
        icon: icons[2],
        iconSize: iconSize,
        title: ("Search"),
        activeColorPrimary: kActivetab,
        inactiveColorPrimary: kUnactivetab,
      ),
      PersistentBottomNavBarItem(
        icon: icons[3],
        iconSize: iconSize,
        title: ("Downloads"),
        activeColorPrimary: kActivetab,
        inactiveColorPrimary: kUnactivetab,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return
        PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          navBarStyle: kNavigatorstyle,
          padding: kNavigatorpadding,
          navBarHeight:kNavigatorHeight,
        );
  }
}
