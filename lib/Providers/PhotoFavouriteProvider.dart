import 'package:artapp/models/PhotoModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PhotoFavouriteNotifier extends ChangeNotifier {
  static Box<Photo>? _photoBox;

  Box<Photo>? get photoBox => _photoBox;

  PhotoFavouriteNotifier() {
    _photoBox = Hive.box<Photo>('photoBox');
  }

  void addPhotoToFavourite(Photo photo) {
    if (!_photoBox!.containsKey(photo.id)) _photoBox?.put(photo.id, photo);
    print(
        '${photo.id} added to the box +++ Total Length>>>>> ${_photoBox?.length}');

    notifyListeners();
  }

  void removePhotoToFavourite(Photo photo) {
    if (_photoBox!.containsKey(photo.id)) _photoBox?.delete(photo.id);
    print(
        '${photo.id} deleted to the box +++ Total Length>>>>> ${_photoBox?.length}');
    notifyListeners();
  }

  void removeAllPhotoFromFavourite() {
    _photoBox?.clear();
    notifyListeners();
  }
}
