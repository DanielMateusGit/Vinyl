
import 'package:flutter/cupertino.dart';
import 'package:vinylproject/model/brano.dart';
import 'package:vinylproject/controllers/brano_db_controller.dart';

class downloadController extends ChangeNotifier{

  List<Brano> _playlistsMusic = [];
  List<Brano> _playlistsPodcast = [];
  List<Brano> _playlistsDMusic = [];
  List<Brano> _playlistsDPodcast = [];
  void aggiornaPlaylistMusic() async {
    _playlistsMusic = await BranoDBController.brani(0);
    notifyListeners();
  }

  List<Brano> getPlaylistMusic() {
    return this._playlistsMusic;
  }
  void aggiornaPlaylistPodcast() async {
    _playlistsPodcast = await BranoDBController.brani(1);
    notifyListeners();
  }

  List<Brano> getPlaylistPodcast() {
    return this._playlistsPodcast;
  }
  void aggiornaPlaylistDMusic() async {
    _playlistsDMusic = await BranoDBController.brani(2);
    notifyListeners();
  }

  List<Brano> getPlaylistDMusic() {
    return this._playlistsDMusic;
  }
  void aggiornaPlaylistDPodcast() async {
    _playlistsDPodcast = await BranoDBController.brani(3);
    notifyListeners();
  }

  List<Brano> getPlaylistDPodcast() {
    return this._playlistsDPodcast;
  }
}