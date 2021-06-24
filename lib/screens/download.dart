import 'package:flutter/material.dart';
import 'package:vinylproject/screens/downloadedAudios.dart';

class Downloads extends StatefulWidget {
  @override
  _DownloadsState createState() => _DownloadsState();
}
class _DownloadsState extends State<Downloads> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          bottom: TabBar(
            indicatorColor: Colors.blueGrey,
            tabs: [
              Tab(text: 'Brani'),
              Tab(text: 'Podcast'),
            ],
          ),
        ),
        body: TabBarView(
          children: ['Brani', 'Podcast']
              .map((name) =>  DowloadedAudios( name:name))
              .toList(growable: false),
        ),
      ),

    );
  }
}