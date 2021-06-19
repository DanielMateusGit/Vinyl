import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// navigator theme settings

  // animations style
  const kNavigatorstyle = NavBarStyle.style12;
  const kNavigatorpadding = NavBarPadding.all(5.0);
  const kNavigatorHeight = 55.0;

  // navigator color scheme
  const Color kActivetab = Colors.black;
  const Color kUnactivetab = Colors.black26;

  // navigator icon setting
  const List<Icon> icons = [Icon(Icons.headset_outlined), Icon(Icons.record_voice_over_outlined), Icon(Icons.search_outlined), Icon(Icons.file_download)];
  const double iconSize = 25.0;


// youtube query theme settings

  // title text format
  const kTextPaddingTop = 20.0;
  const kTextPaddingLeft = 10.0;
  const kTitleFontSize = 18.0;