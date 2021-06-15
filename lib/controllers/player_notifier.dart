import 'package:flutter/cupertino.dart';

class Playernotifier extends ChangeNotifier{

  //informaciòn "el player no està reproduciendo musica entonces es invisible"
  bool _visible = true;
  String _currentThumbnail;
  String _CurrenTitle;

  void changeVisibility(bool visibility){
    this._visible = visibility;
    notifyListeners();
  }

  void changeThumbnail(String thumbnail){
    this._currentThumbnail = thumbnail;
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

  String getTitle(){
    return this._CurrenTitle;
  }

}