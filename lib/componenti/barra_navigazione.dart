import 'package:flutter/material.dart';

class barra_navigazione extends StatelessWidget {
  const barra_navigazione({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          label: 'Music',
          icon: Icon(Icons.headset_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Poadcast',
          icon: Icon(Icons.record_voice_over_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Search',
          icon: Icon(Icons.search_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Downloads',
          icon: Icon(Icons.file_download),
        ),
      ],
    );
  }
}

// dan smettila con la coca