import 'package:artapp/APIs/APIConnection.dart';
import 'package:artapp/Providers/VideoProvider.dart';
import 'package:artapp/models/VideoModel.dart';
import 'package:artapp/pages/DetailScreens/VideoDetailPage.dart';
import 'package:artapp/widgets/Loaders.dart';
import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoListTile extends StatefulWidget {
  final bool isFromLocal;
  const VideoListTile({Key? key, this.isFromLocal = false}) : super(key: key);

  @override
  _VideoListTileState createState() => _VideoListTileState();
}

class _VideoListTileState extends State<VideoListTile> {
  late ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!widget.isFromLocal)
          Provider.of<VideoNotifier>(context, listen: false).fetchMoreData();
      }
    });
    if (widget.isFromLocal)
      Provider.of<VideoNotifier>(context, listen: false).fetchDataFromLocalDb();
    else
      Provider.of<VideoNotifier>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = getThemeDataOfContext(context);
    Size screenSize = getMediaQuerySize(context);
    return Consumer<VideoNotifier>(builder: (ctx, videoProvider, child) {
      return !videoProvider.isLoaded
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
                      itemCount: widget.isFromLocal
                          ? videoProvider.videoBox?.length
                          : videoProvider.videosList.length,
                      itemBuilder: (BuildContext context, int indexChild) {
                        Video video = widget.isFromLocal
                            ? videoProvider.videoBox?.getAt(indexChild) ??
                                Video()
                            : videoProvider.videosList[indexChild];
                        return VideoTile(
                          video: video,
                        );
                      }),
                  SizedBox(height: 10),
                  Visibility(
                      visible: videoProvider.isMoreLoading,
                      child: Container(
                          height: 30,
                          width: 30,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: CircularLoader(
                            showBackgroud: false,
                          )))
                ],
              ));
    });
  }
}

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
                textAlign: TextAlign.center,
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
