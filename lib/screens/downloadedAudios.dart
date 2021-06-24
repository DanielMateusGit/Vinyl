import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinylproject/controllers/AudiosController.dart';


class DowloadedAudios extends StatefulWidget {
  final String name;

  DowloadedAudios({this.name});

  @override
  DownloadedAudios createState() => DownloadedAudios(name: name);
}

class DownloadedAudios extends State<DowloadedAudios> {
  final String name;

  DownloadedAudios({this.name});

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
