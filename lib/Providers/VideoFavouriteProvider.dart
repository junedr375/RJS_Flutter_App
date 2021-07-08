import 'package:artapp/models/VideoModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

//Provider for Saving Videos to Local Database
class VideoFavouriteNotifier extends ChangeNotifier {
  static Box<Video>? _videoBox;

  Box<Video>? get videoBox => _videoBox;

  VideoFavouriteNotifier() {
    _videoBox = Hive.box<Video>('videoBox');
  }

  void addVideoToFavourite(Video video) {
    if (!_videoBox!.containsKey(video.id)) _videoBox?.put(video.id, video);
    print(
        '${video.id} Video added  to the box +++ Total Length>>>>> ${_videoBox?.length}');
    notifyListeners();
  }

  void removeVideoFromFavourite(Video video) {
    if (_videoBox!.containsKey(video.id)) _videoBox?.delete(video.id);
    print(
        '${video.id} Video deleted to the box +++ Total Length>>>>> ${_videoBox?.length}');
    notifyListeners();
  }

  void removeAllPhotoFromFavourite() {
    _videoBox?.clear();
    notifyListeners();
  }
}
