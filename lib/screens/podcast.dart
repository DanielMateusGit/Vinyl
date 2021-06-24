import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinylproject/controllers/AudiosController.dart';
import 'package:vinylproject/controllers/brano_db_controller.dart';
import 'package:vinylproject/controllers/playlist_db_controller.dart';
import 'package:vinylproject/model/brano.dart';
import 'package:vinylproject/model/playlist.dart';

class Podcast extends StatefulWidget  {

  @override
  PodcastState createState() => PodcastState();
}

class PodcastState extends State<Podcast> {

  @override
  void initState() {

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: AssetImage('assets/ELON.png'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TEDx',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'Top week Speaker',
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, top:40, bottom: 10),
              child: Text(
                'Poads',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: Consumer<downloadController>(
                builder: (context, controller, child) {
                  controller.aggiornaPlaylistPodcast();
                  return ListView.builder(
                    itemCount: controller.getPlaylistPodcast().length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(),
                        child: controller.getPlaylistPodcast()[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}