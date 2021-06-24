import 'dart:io';

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
                        color: Colors.black45,
                        child: CurrentSong(
                          title: player.getTitle(),
                          thumbnail: player.getThumbnail(),
                          localThumbnail: player.getLocalThumbnail(),
                        ),
                      );
                    } else {
                      return Container(
                        color: Colors.black45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: Center(
                                  child: Container(
                                      width: 300.0,
                                      height: 300.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: player.getLocalThumbnail()==null? new    NetworkImage(player.getThumbnail())
                                                :new FileImage(File(player.getLocalThumbnail())),
                                            fit: BoxFit.cover),
                                      )),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Text(
                                player.getTitle(),
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
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
                                      size: 60,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                                    child: Consumer<AudioController>(
                                      builder: (context, player, child) {
                                        return player.getPlayingState()
                                            ? GestureDetector(

                                          onTap: () {
                                            player.pause();
                                          },
                                          child: Icon(
                                            Icons.pause,
                                            size: 60,
                                            color: Colors.black,
                                          ),
                                        )
                                            : GestureDetector(
                                          onTap: () {
                                            player.resume();
                                          },
                                          child: Icon(
                                            Icons.play_arrow,
                                            size: 60,
                                            color: Colors.black,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Icon(
                                    Icons.skip_next,
                                    size: 60,
                                    color: Colors.black,
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
  CurrentSong({this.thumbnail, this.title,this.localThumbnail});

  final String thumbnail;
  final String localThumbnail;
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
                    image: localThumbnail==null? new NetworkImage(thumbnail):new FileImage(File(localThumbnail)), fit: BoxFit.cover),
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
                    color: Colors.black,
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
                      color: Colors.black,
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      player.resume();
                    },
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.black,
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
