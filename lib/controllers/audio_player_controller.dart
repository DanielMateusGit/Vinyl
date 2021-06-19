
import 'package:audioplayers/audioplayers.dart';

class AudioController{

  // use of pattern singleton
  static final AudioController _singleton = AudioController._internal();

  factory AudioController() {
    return _singleton;
  }

  AudioController._internal();

  // instance of player from audioplayers package
  AudioPlayer _player = AudioPlayer();


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

    }catch(e){

      print(e);
      print('unable to play file');
    }
  }

  // pause an audio from url
  Future<void> pause(String url) async {
    try{

      int result = await _player.stop();

    }catch(e){

      print(e);
      print('unable to pause file');
    }
  }

  // resume and audio (who was in pause status)
  Future<void> resume(String url) async {
    try{

      int result = await _player.resume();

    }catch(e){

      print(e);
      print('unable to resume file');
    }
  }

  // jump through audio
  Future<void> jump(int milliseconds) async {
    try{

      int result = await _player.seek(Duration(milliseconds: milliseconds));

    }catch(e){

      print(e);
      print('unable to jump trough file');
    }
  }

}