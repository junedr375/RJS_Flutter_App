import 'package:artapp/APIs/APIConnection.dart';
import 'package:artapp/models/PhotoModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class PhotoNotifier extends ChangeNotifier {
  Box<Photo>? _photoBox;

  PhotoNotifier() {
    _photoBox = Hive.box<Photo>('photoBox');
  }

  List<Photo> _photosList = [];
  bool _isLoaded = false;
  bool _isMoreLoading = false;
  int _pagedIndex = 1;

  Box<Photo>? get photoBox => _photoBox;
  List<Photo> get photosList => _photosList;
  bool get isLoaded => _isLoaded;
  bool get isMoreLoading => _isMoreLoading;
  int get pagedIndex => _pagedIndex;

  fetchDataFromLocalDb() {
    _photosList.clear();

    for (var i = 0; i < _photoBox!.length; i++) {
      _photosList.add(_photoBox?.getAt(i) ?? Photo());
    }
    _isLoaded = true;
    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
  }

  fetchData() async {
    _photosList = await APIConnection.getPhotosFromAPI(_pagedIndex);
    _isLoaded = true;

    notifyListeners();
  }

  fetchMoreData() async {
    _pagedIndex++;
    _isMoreLoading = true;
    notifyListeners();

    List<Photo> temList = await APIConnection.getPhotosFromAPI(_pagedIndex);

    photosList.addAll(temList);
    _isMoreLoading = false;
    notifyListeners();
  }
}
