import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:vinylproject/constants.dart';
import 'package:vinylproject/controllers/audio_player_controller.dart';
import 'package:vinylproject/controllers/brano_db_controller.dart';
import 'package:vinylproject/controllers/playlist_db_controller.dart';
import 'package:vinylproject/model/brano.dart';
import 'package:vinylproject/model/playlist.dart';
import 'package:vinylproject/screens/music.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:vinylproject/controllers/player_notifier.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class YoutubeQuery extends StatelessWidget {
  // audio player got from singleton
  AudioController _audio = AudioController();

  final String title;
  final String thumbnail;
  final String url;
  final String channel;

  // default constructor
  YoutubeQuery({
    this.title,
    this.thumbnail,
    this.url,
    this.channel,
  });

  // json constructor
  factory YoutubeQuery.fromJson(dynamic json, int i) {
    return YoutubeQuery(
      title: json['items'][i]['snippet']['title'],
      thumbnail: json['items'][i]['snippet']['thumbnails']['high']['url'],
      url: json['items'][i]['id']['videoId'],
      channel: json['items'][i]['snippet']['channelTitle'],
    );
  }

  // get media from youtube
  Future<String> _getMedia() async {
    var youtubeMediaExtractor = YoutubeExplode();

    try {
      var manifest =
          await youtubeMediaExtractor.videos.streamsClient.getManifest(url);
      var streamInfo = manifest.audioOnly.withHighestBitrate();

      youtubeMediaExtractor.close();
      return streamInfo.url.toString();
    } catch (e) {
      print(e);
      return 'Unable to find data';
    }
  }

  Future<void> _downloadMedia() async {
    var status = await Permission.storage.request();

      // code of read or write file in external storage (SD card)
      var youtubeMediaExtractor = YoutubeExplode();

      try {
        var manifest =
        await youtubeMediaExtractor.videos.streamsClient.getManifest(url);
        var streamInfo = manifest.audioOnly.withHighestBitrate();
        if (streamInfo != null) {
          // Get the actual stream
          var stream = youtubeMediaExtractor.videos.streamsClient.get(
              streamInfo);

          // Open a file for writing.
          var fileName = '$url.${streamInfo.container.name.toString()}'
              .replaceAll(r'\', '')
              .replaceAll('/', '')
              .replaceAll('*', '')
              .replaceAll('?', '')
              .replaceAll('"', '')
              .replaceAll('<', '')
              .replaceAll('>', '')
              .replaceAll('|', '');
          Directory appDocDir = await getApplicationDocumentsDirectory();
          String appDocPath = appDocDir.path;

          var file = File('$appDocPath/$fileName');

          var fileStream = file.openWrite();

          // Pipe all the content of the stream into the file.
          await stream.pipe(fileStream);

          // Close the file.
          await fileStream.flush();
          await fileStream.close();

          youtubeMediaExtractor.close();

          Brano b = new Brano(nome:title,url:'$appDocPath/$fileName',channel:channel,image:thumbnail,idPlaylist: 2);
          await BranoDBController.insertBrano(b);
          print("scaricato");
        }
      } catch (e) {
        print(e);
        return 'Unable to find data';

    }
  }

  // update miniplayer
  void update(BuildContext context) {
    // update miniplayer by provider
    Provider.of<Playernotifier>(context, listen: false).changeVisibility(false);
    Provider.of<Playernotifier>(context, listen: false)
        .changeThumbnail(thumbnail);
    Provider.of<Playernotifier>(context, listen: false).changeTitle(title);
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
                      String getUrl = await _getMedia();
                      _audio.prepare(getUrl);
                      _audio.play(getUrl);
                    },
                    child: new Container(
                      child: new Padding(
                        child: new Image.network(
                          thumbnail,
                          fit: BoxFit.cover,
                          width: 160.0,
                          height: 90.0,
                        ),
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
                        String getUrl = await _getMedia();
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
                                title,
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
                      onChanged: (String newValue) {
                        if (newValue == "Scarica") {
                          _downloadMedia();


                        }
                        if (newValue == "Aggiungi")
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Text('Aggiungi a Playlist'),
                                  actions: [
                                    ElevatedButton(
                                        child: Text("Podcast"),
                                        onPressed: () async {
                                          Brano f = new Brano(
                                              nome: title,
                                              idPlaylist: 1,
                                              channel: channel,
                                              image: thumbnail,
                                              url: await _getMedia());
                                          await BranoDBController.insertBrano(
                                              f);

                                            context
                                                .findRootAncestorStateOfType<MusicState>()
                                                .init();
                                          Navigator.pop(context);
                                        }),
                                    ElevatedButton(
                                        child: Text("Musica"),
                                        onPressed: () async {
                                          Brano f = new Brano(
                                              nome: title,
                                              idPlaylist: 0,
                                              channel: channel,
                                              image: thumbnail,
                                              url: await _getMedia());
                                          await BranoDBController.insertBrano(
                                              f);

                                          Navigator.pop(context);
                                        })
                                  ],
                                );
                              });
                      },
                      underline: Container(
                        height: 0,
                      ),
                      items: <String>['Scarica', 'Aggiungi']
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
