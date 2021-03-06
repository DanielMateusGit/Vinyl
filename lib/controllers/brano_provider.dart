
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class BranoController extends ChangeNotifier{

  // use of pattern singleton
  static final BranoController _singleton = BranoController._internal();

  factory BranoController() {
    return _singleton;
  }

  BranoController._internal();

  // instance of player from audioplayers package
  AudioPlayer _player = AudioPlayer();

  // is current song playing?
  bool _playing = false;

  // prepare an audio to play an url, but doesn't play it
  Future<void> prepare(String url) async {
    try{
       await _player.setUrl(url);

    }catch(e){
      print(e);
    }
  }

  // play an audio from url
  Future<void> play(String url) async {
    try{

      await _player.play(url);
      _playing = true;
      notifyListeners();

    }catch(e){

      print(e);
      print('unable to play file');
    }
  }

  // pause an audio from url
  Future<void> pause() async {
    try{

       await _player.stop();
      _playing = false;
      notifyListeners();

    }catch(e){

      print(e);
      print('unable to pause file');
    }
  }

  // resume and audio (who was in pause status)
  Future<void> resume() async {
    try{

      await _player.resume();
      _playing = true;
      notifyListeners();
    }catch(e){

      print(e);
      print('unable to resume file');
    }
  }

  // jump through audio
  Future<void> jump(int milliseconds) async {
    try{

      await _player.seek(Duration(milliseconds: milliseconds));
      notifyListeners();

    }catch(e){

      print(e);
      print('unable to jump trough file');
    }
  }

  bool getPlayingState(){
    return this._playing;
  }

}