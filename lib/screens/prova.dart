import 'package:flutter/material.dart';
import 'package:vinylproject/controllers/brano_db_controller.dart';
import 'package:vinylproject/model/brano.dart';

class dowloadedAudios extends StatefulWidget  {
  final String name;
  dowloadedAudios({ this.name});
  @override
  downloadedAudios createState() => downloadedAudios(name: name);
}
class downloadedAudios extends  State<dowloadedAudios>{

  final String name;
   downloadedAudios({ this.name});

  List<Brano> _playlists = [];
  @override
  bool get wantKeepAlive => false;
  @override
  void initState() {
    init();
  }

  init() async {
    //esempio da eliminare
    _playlists = await BranoDBController.brani(name=="Brani"?2:3);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

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