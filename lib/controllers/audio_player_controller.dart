
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class AudioController extends ChangeNotifier{

  // use of pattern singleton
  static final AudioController _singleton = AudioController._internal();

  factory AudioController() {
    return _singleton;
  }

  AudioController._internal();

  // instance of player from audioplayers package
  AudioPlayer _player = AudioPlayer();

  // is current song playing?
  bool _playing = false;

  // prepare an audio to play an url, but doesn't play it
  Future<void> prepare(String url) async {
    try{
      int result = await _player.setUrl(url);

    }catch(e){
      print(e);
    }
  }

  // play an audio from url
  Future<void> play(String url) async {
    try{

      int result = await _player.play(url);
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

      int result = await _player.stop();
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

      int result = await _player.resume();
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

      int result = await _player.seek(Duration(milliseconds: milliseconds));
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