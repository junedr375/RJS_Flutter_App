import 'package:artapp/APIs/APIConnection.dart';
import 'package:artapp/models/VideoModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class VideoNotifier extends ChangeNotifier {
  static Box<Video>? _videoBox;
  VideoNotifier() {
    _videoBox = Hive.box<Video>('videoBox');
  }
  static List<Video> _videosList = [];
  bool _isLoaded = false;
  bool _isMoreLoading = false;
  int _pagedIndex = 1;

  Box<Video>? get videoBox => _videoBox;
  List<Video> get videosList => _videosList;
  bool get isLoaded => _isLoaded;
  bool get isMoreLoading => _isMoreLoading;
  int get pagedIndex => _pagedIndex;

  fetchDataFromLocalDb() {
    _videosList.clear();

    for (var i = 0; i < _videoBox!.length; i++) {
      _videosList.add(_videoBox?.getAt(i) ?? Video());
    }
    _isLoaded = true;
    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
  }

  Future fetchData() async {
    _videosList = await APIConnection.getVideosFromAPI(_pagedIndex);

    _isLoaded = true;
    notifyListeners();
  }

  fetchMoreData() async {
    _pagedIndex++;
    _isMoreLoading = true;
    notifyListeners();

    List<Video> temList = await APIConnection.getVideosFromAPI(_pagedIndex);

    _videosList.addAll(temList);
    _isMoreLoading = false;
    notifyListeners();
  }
}
