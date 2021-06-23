import 'package:flutter/material.dart';
import 'package:vinylproject/controllers/brano_db_controller.dart';
import 'package:vinylproject/controllers/playlist_db_controller.dart';
import 'package:vinylproject/model/brano.dart';
import 'package:vinylproject/model/playlist.dart';

class Music extends StatefulWidget {
  @override
  MusicState createState() => MusicState();
}

class MusicState extends State<Music> {
  List<Brano> _playlists = [];

  @override
  void initState() {
    init();
  }

  init() async {
    _playlists = await BranoDBController.brani(0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 25.0),
            child: Text(
              'Music',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
                fontSize: 30,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _playlists.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(),
                  child: _playlists[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
