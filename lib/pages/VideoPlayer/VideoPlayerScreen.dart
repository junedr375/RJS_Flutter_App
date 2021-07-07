import 'package:artapp/models/VideoModel.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Video? video;
  const VideoPlayerScreen({Key? key, this.video}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  List<BetterPlayerDataSource> dataSourceList = [];

  @override
  void initState() {
    super.initState();
    createDataSet();
  }

  List<BetterPlayerDataSource> createDataSet() {
    widget.video?.videoFiles?.map((videoFile) {
      dataSourceList.add(
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          videoFile.link ??
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
        ),
      );
    }).toList();

    print('L:engtt?>>>>>>>>>>' + dataSourceList.length.toString());

    return dataSourceList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayerPlaylist(
              betterPlayerConfiguration: BetterPlayerConfiguration(
                  autoDetectFullscreenDeviceOrientation: true,
                  fullScreenByDefault: true,
                  autoDispose: true,
                  autoPlay: true),
              betterPlayerPlaylistConfiguration:
                  const BetterPlayerPlaylistConfiguration(
                      loopVideos: false, nextVideoDelay: Duration(seconds: 5)),
              betterPlayerDataSourceList: dataSourceList),
        ));
  }
}
