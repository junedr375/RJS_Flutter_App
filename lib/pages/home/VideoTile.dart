import 'package:artapp/APIs/APIConnection.dart';
import 'package:artapp/models/VideoModel.dart';
import 'package:artapp/pages/DetailScreens/VideoDetailPage.dart';
import 'package:artapp/widgets/Loaders.dart';
import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatefulWidget {
  final Video? video;
  const VideoTile({Key? key, @required this.video}) : super(key: key);

  @override
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = getMediaQuerySize(context);
    final theme = getThemeDataOfContext(context);
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoDetailsPage(video: widget.video)));
        },
        child: Container(
            child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: Key(widget.video?.id.toString() ?? ''),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.video?.videoPictures?[0].picture ?? '',
                    width: screenSize.width * 0.3,
                    fit: BoxFit.cover,
                    loadingBuilder: imageLoader,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                widget.video?.user?.name ?? '',
                style: theme.textTheme.headline4,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        )));
  }
}

class VideoListTile extends StatefulWidget {
  const VideoListTile({Key? key}) : super(key: key);

  @override
  _VideoListTileState createState() => _VideoListTileState();
}

class _VideoListTileState extends State<VideoListTile> {
  List<Video> videosList = [];
  bool isLoaded = false;
  bool isMoreLoading = false;
  int pagedIndex = 1;

  late ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchMoreData();
      }
    });
    fetchDataHere();
  }

  fetchDataHere() async {
    videosList = await APIConnection.getVideosFromAPI(1);
    if (mounted)
      setState(() {
        isLoaded = true;
      });
  }

  fetchMoreData() async {
    setState(() {
      pagedIndex++;
      isMoreLoading = true;
    });

    List<Video> temList = await APIConnection.getVideosFromAPI(pagedIndex);
    if (mounted) {
      setState(() {
        videosList.addAll(temList);
        isMoreLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = getThemeDataOfContext(context);
    Size screenSize = getMediaQuerySize(context);
    return !isLoaded
        ? CircularLoader()
        : SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: videosList.length,
                    itemBuilder: (BuildContext context, int indexChild) {
                      Video video = videosList[indexChild];
                      return VideoTile(
                        video: video,
                      );
                    }),
                SizedBox(height: 10),
                Visibility(
                    visible: isMoreLoading,
                    child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        child: CircularLoader(
                          showBackgroud: false,
                        )))
              ],
            ));
  }
}
