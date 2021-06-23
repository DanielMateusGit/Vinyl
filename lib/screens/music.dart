import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinylproject/controllers/brano_db_controller.dart';
import 'package:vinylproject/controllers/playlist_db_controller.dart';
import 'package:vinylproject/model/brano.dart';
import 'package:vinylproject/model/playlist.dart';
import 'package:vinylproject/controllers/AudiosController.dart';

class Music extends StatefulWidget {
  @override
  MusicState createState() => MusicState();
}

class MusicState extends State<Music> {

  @override
  void initState() {
    init();
  }

  init() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
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
            child: Consumer<downloadController>(
              builder: (context, controller, child) {
                controller.aggiornaPlaylist();
                return ListView.builder(
                  itemCount: controller.getPlaylist().length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(),
                      child: controller.getPlaylist()[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
