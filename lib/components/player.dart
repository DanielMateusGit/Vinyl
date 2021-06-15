import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
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
          padding: EdgeInsets.only(bottom: 61.0),
          child: Consumer<Playernotifier>(
            builder: (context, player, child) {
              return Offstage(
                offstage: player.getVisibility(),
                child: Miniplayer(
                  minHeight: 100,
                  maxHeight: height,
                  builder: (height, percentage) {
                    if (height <= 100 && player.getTitle() != null) {
                      return Container(
                        color: Colors.white,
                        child: CurrentSong(
                          title: player.getTitle(),
                          thumbnail: player.getThumbnail(),
                        ),
                      );
                    } else {
                      return Text('Totale Visualizzazione');
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
    return Row(
      children: [
        Container(
          width: 150.0,
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
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
