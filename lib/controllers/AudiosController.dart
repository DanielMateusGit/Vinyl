
import 'package:flutter/cupertino.dart';
import 'package:vinylproject/model/brano.dart';
import 'package:vinylproject/controllers/brano_db_controller.dart';

class downloadController extends ChangeNotifier{

  List<Brano> _playlists = [];

  void aggiornaPlaylist() async {
    _playlists = await BranoDBController.brani(0);
    notifyListeners();
  }

  List<Brano> getPlaylist() {
    return this._playlists;
  }

}