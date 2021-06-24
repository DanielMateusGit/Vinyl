
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/material.dart';
import 'package:vinylproject/model/brano.dart';
import 'package:vinylproject/screens/download.dart';
import 'package:vinylproject/screens/music.dart';
import 'package:vinylproject/screens/podcast.dart';

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
        icon: Icon(Icons.headset_outlined),
        iconSize: iconSize,
        title: ("Music"),
        activeColorPrimary: kActivetab,
        inactiveColorPrimary: kUnactivetab,
      ),
      PersistentBottomNavBarItem(
        icon:  Icon(Icons.record_voice_over_outlined),
        iconSize: iconSize,
        title: ("Poadcast"),
        activeColorPrimary: kActivetab,
        inactiveColorPrimary: kUnactivetab,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search_outlined),
        iconSize: iconSize,
        title: ("Search"),
        activeColorPrimary: kActivetab,
        inactiveColorPrimary: kUnactivetab,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.file_download),
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

          backgroundColor: Colors.white10,
        );
  }
}
