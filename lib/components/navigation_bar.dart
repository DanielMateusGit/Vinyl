import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/material.dart';
import 'package:vinylproject/screens/download.dart';
import 'package:vinylproject/screens/music.dart';
import 'package:vinylproject/screens/poadcast.dart';
import 'package:vinylproject/screens/search.dart';

class NavigationBar extends StatelessWidget {

  //Schermate della navigazione
  List<Widget> _buildScreens() => [Music(), Poadcast(), Search(), Downloads()];

  //Controller della navigazione
  final PersistentTabController _controller  = PersistentTabController(initialIndex: 0);

  // Icone della navigazione
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.headset_outlined),
        iconSize: 30.0,
        title: ("Music"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.record_voice_over_outlined),
        iconSize: 30.0,
        title: ("Poadcast"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search_outlined),
        iconSize: 30.0,
        title: ("Search"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.file_download),
        iconSize: 30.0,
        title: ("Downloads"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
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
          navBarStyle: NavBarStyle.style12,
          padding: NavBarPadding.all(13.0),
          navBarHeight: 61.0,
        );
  }
}
