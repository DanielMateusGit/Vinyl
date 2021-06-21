import 'package:flutter/material.dart';
import 'package:vinylproject/constants.dart';
import 'package:vinylproject/controllers/playlist_db_controller.dart';
import 'package:vinylproject/model/playlist.dart';

class Podcast extends StatefulWidget {

  @override
  _PodcastState createState() => _PodcastState();
}

class _PodcastState extends State<Podcast> {
  List<Playlist> _playlists = [];
  @override
  void initState() {
    init();
  }
  init() async
  {



    //esempio da eliminare
    Playlist f = new Playlist(nome: "ciawdwooo",id:9,tipo: 1,sottotitolo: "cwdwdcoo",);
    await PlaylistDBController.insertPlaylist(f);


    _playlists=await PlaylistDBController.Playlists(1);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 25.0),
            child: Text('_Podcast', style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              fontSize: 18,
            ),),
          ),


          Expanded(
            child:  ListView.builder(
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
