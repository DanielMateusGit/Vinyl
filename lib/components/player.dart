import 'package:flutter/cupertino.dart';
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
          padding: EdgeInsets.only(bottom: 55.0),
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
                        color: Colors.white,
                        child: CurrentSong(
                          title: player.getTitle(),
                          thumbnail: player.getThumbnail(),
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text('prova di un bottone'),
                            onPressed: (){
                              print('bottone premuto');
                            },
                          )
                        ],
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
      mainAxisAlignment: MainAxisAlignment.center,
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
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                print('toccato il bottone play');
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
