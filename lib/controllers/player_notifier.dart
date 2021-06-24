import 'package:flutter/cupertino.dart';

class Playernotifier extends ChangeNotifier{


  bool _visible = true;
  String _currentThumbnail;
  String _currentLocalThumbnail;
  String _CurrenTitle;

  void changeVisibility(bool visibility){
    this._visible = visibility;
    notifyListeners();
  }

  void changeThumbnail(String thumbnail){
    this._currentThumbnail = thumbnail;
    notifyListeners();
  }
  void changeLocalThumbnail(String thumbnail){
    this._currentLocalThumbnail = thumbnail;
    notifyListeners();
  }
  void changeTitle(String title){
    this._CurrenTitle = title;
    notifyListeners();
  }

  bool getVisibility(){
    return this._visible;
  }

  String getThumbnail(){
    return this._currentThumbnail;
  }
  String getLocalThumbnail(){
    return this._currentLocalThumbnail;
  }
  String getTitle(){
    return this._CurrenTitle;
  }

}