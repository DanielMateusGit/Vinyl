import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinylproject/controllers/AudiosController.dart';
import 'package:vinylproject/controllers/brano_db_controller.dart';
import 'package:vinylproject/model/brano.dart';

class dowloadedAudios extends StatefulWidget {
  final String name;

  dowloadedAudios({this.name});

  @override
  downloadedAudios createState() => downloadedAudios(name: name);
}

class downloadedAudios extends State<dowloadedAudios> {
  final String name;

  downloadedAudios({this.name});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        Consumer<downloadController>(builder: (context, controller, child) {
          this.name=="Brani"? controller.aggiornaPlaylistDMusic():controller.aggiornaPlaylistDPodcast();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: this.name=="Brani"? controller.getPlaylistDMusic().length: controller.getPlaylistDPodcast().length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(),
                  child: this.name=="Brani"? controller.getPlaylistDMusic()[index]:controller.getPlaylistDPodcast()[index]
                );
              },
            ),
          ),
        ],
      );
    }));
  }
}
