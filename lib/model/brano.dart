import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinylproject/controllers/audio_player_controller.dart';
import 'package:vinylproject/controllers/brano_db_controller.dart';
import 'package:vinylproject/controllers/player_notifier.dart';
import 'package:vinylproject/screens/music.dart';

class Brano extends StatelessWidget {
  final int id;
  final String nome;
  final String url;
  final String path;
  final String channel;
  final String image;
  final int idPlaylist;

  Brano(
      {this.nome,
      this.id,
      this.url,
      this.path,
      this.channel,
      this.image,
      this.idPlaylist});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'url': url,
      'path': path,
      'image': image,
      'channel': channel,
      'idPlaylist': idPlaylist
    };
  }

  AudioController _audio = AudioController();

  void update(BuildContext context) {
    // update miniplayer by provider
    Provider.of<Playernotifier>(context, listen: false).changeVisibility(false);
    Provider.of<Playernotifier>(context, listen: false).changeThumbnail(image);
    Provider.of<Playernotifier>(context, listen: false).changeTitle(nome);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      // update miniplayer
                      update(context);

                      // play audio
                      String getUrl = url;
                      _audio.prepare(getUrl);
                      _audio.play(getUrl);
                    },
                    child: new Container(
                      child: new Padding(
                        child:  Image.network(
                          image,
                          fit: BoxFit.cover,
                          width: 160.0,
                          height: 90.0,
                        ) ,
                        padding: const EdgeInsets.all(4.0),
                      ),
                      padding: const EdgeInsets.all(0.0),
                      alignment: Alignment.centerLeft,
                      width: 80.0,
                      height: 45.0,
                    ),
                  ),
                  new Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // update miniplayer
                        update(context);

                        // play audio
                        String getUrl = url;
                        _audio.prepare(getUrl);
                        _audio.play(getUrl);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                nome,
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    color: const Color(0xFFffffff),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Roboto"),
                              ),
                              new Text(
                                channel,
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    color: const Color(0xFFffffff),
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Roboto"),
                              )
                            ]),
                      ),
                    ),
                  ),
                  new Container(
                    child: new DropdownButton<String>(
                      isExpanded: true,
                      icon: const Icon(Icons.more_vert),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (String newValue) async {
                        if (newValue == "Rimuovi") {
                          await BranoDBController.deleteBrano(id);
                          if (context.findAncestorStateOfType<_MusicState>() !=
                              null)
                            context
                                .findRootAncestorStateOfType<_MusicState>()
                                .init();
                          if (context
                                  .findAncestorStateOfType<_PodcastState>() !=
                              null)
                            context
                                .findRootAncestorStateOfType<_PodcastState>()
                                .init();

                        }
                      },
                      underline: Container(
                        height: 0,
                      ),
                      items: <String>['Rimuovi']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment.centerLeft,
                    width: 60.0,
                    height: 50.0,
                  ),
                ]))
      ],
    );
  }
}

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
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

class Podcast extends StatefulWidget  {
  @override
  _PodcastState createState() => _PodcastState();
}

class _PodcastState extends State<Podcast> with AutomaticKeepAliveClientMixin<Podcast> {
  List<Brano> _playlists = [];
  @override
  bool get wantKeepAlive => false;
  @override
  void initState() {
    init();
  }

  init() async {
    //esempio da eliminare

    _playlists = await BranoDBController.brani(1);
    setState(() {});
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
              'Podcast',
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
