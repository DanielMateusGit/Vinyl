import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinylproject/constants.dart';
import 'package:vinylproject/controllers/audio_player_controller.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:vinylproject/controllers/player_notifier.dart';

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

  // update miniplayer
  void update(BuildContext context) {
    // update miniplayer by provider
    Provider.of<Playernotifier>(context, listen: false).changeVisibility(false);
    Provider.of<Playernotifier>(context, listen: false).changeThumbnail(thumbnail);
    Provider.of<Playernotifier>(context, listen: false).changeTitle(title);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 230.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(thumbnail), fit: BoxFit.cover),
            ),
          ),
          onTap: () async {
            // update miniplayer
            update(context);

            // play audio
            String getUrl = await _getMedia();
            _audio.prepare(getUrl);
            _audio.play(getUrl);
          },
        ),
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(top: kTextPaddingTop),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: kTextPaddingLeft),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: kTitleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: kTextPaddingLeft),
                        child: Text(channel)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(right: kTextPaddingLeft, top: kTextPaddingTop, left: kTextPaddingLeft),
                child: Icon(
                  Icons.more_vert,
                ),
              ),
              onTap: (){

              },
            ),
          ],
        ),
      ],
    );
  }
}
