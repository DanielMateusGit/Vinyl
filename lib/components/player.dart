import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:vinylproject/controllers/audio_player_controller.dart';
import 'package:vinylproject/controllers/player_notifier.dart';

class Player extends StatelessWidget {
  Player({this.height, this.percentage, this.child});

  final double height;
  final double percentage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        child,
        Padding(
          padding: EdgeInsets.only(bottom: 51.0),
          child: Consumer<Playernotifier>(
            builder: (context, player, child) {
              return Offstage(
                offstage: player.getVisibility(),
                child: Miniplayer(
                  minHeight: 70,
                  maxHeight: height,
                  builder: (height, percentage) {
                    if (height <= 70 && player.getTitle() != null) {
                      return Container(
                        color: Colors.black12,
                        child: CurrentSong(
                          title: player.getTitle(),
                          thumbnail: player.getThumbnail(),
                        ),
                      );
                    } else {
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.yellow,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: Center(
                                  child: Icon(
                                    Icons.music_note,
                                    size: 300.0,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: Icon(
                                      Icons.skip_previous,
                                      size: 50,
                                    ),
                                  ),
                                  Icon(
                                    Icons.play_arrow,
                                    size: 70,
                                  ),
                                  Icon(
                                    Icons.skip_next,
                                    size: 50,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CurrentSong extends StatelessWidget {
  CurrentSong({this.thumbnail, this.title});

  final String thumbnail;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 160.0,
              height: 70.0,
              decoration: BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(thumbnail), fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Flexible(
              child: Container(
                padding: new EdgeInsets.only(right: 10.0),
                child: Text(
                  title,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Consumer<AudioController>(
                builder: (context, player, child) {
                  return player.getPlayingState()
                      ? GestureDetector(

                    onTap: () {
                      player.pause();
                    },
                    child: Icon(
                      Icons.pause,
                      color: Colors.white,
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      player.resume();
                    },
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
