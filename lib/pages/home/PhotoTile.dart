import 'package:artapp/APIs/APIConnection.dart';
import 'package:artapp/Providers/PhotoProvider.dart';
import 'package:artapp/models/PhotoModel.dart';
import 'package:artapp/pages/DetailScreens/PhotoDetailPage.dart';
import 'package:artapp/widgets/Loaders.dart';
import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

//TO show list of Photos
class PhotoListTile extends StatefulWidget {
  final bool isFromLocal;
  const PhotoListTile({Key? key, this.isFromLocal = false}) : super(key: key);

  @override
  _PhotoListTileState createState() => _PhotoListTileState();
}

class _PhotoListTileState extends State<PhotoListTile> {
  late ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!widget.isFromLocal)
          Provider.of<PhotoNotifier>(context, listen: false)
              .fetchMoreData(); // When scrolling to end it will fetch more Photos
      }
    });
    if (widget.isFromLocal)
      Provider.of<PhotoNotifier>(context, listen: false).fetchDataFromLocalDb();
    else
      Provider.of<PhotoNotifier>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = getThemeDataOfContext(context);
    Size screenSize = getMediaQuerySize(context);
    return Consumer<PhotoNotifier>(builder: (ctx, photoProvider, child) {
      return !photoProvider.isLoaded
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
                          ? photoProvider.photoBox?.length
                          : photoProvider.photosList.length,
                      itemBuilder: (BuildContext context, int indexChild) {
                        Photo photo = widget.isFromLocal
                            ? photoProvider.photoBox?.getAt(indexChild) ??
                                Photo()
                            : photoProvider.photosList[indexChild];
                        return PhotoTile(
                          photo: photo,
                        );
                      }),
                  SizedBox(height: 10),
                  Visibility(
                      visible: photoProvider.isMoreLoading,
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

class PhotoTile extends StatefulWidget {
  final Photo? photo;
  const PhotoTile({Key? key, @required this.photo}) : super(key: key);

  @override
  _PhotoTileState createState() => _PhotoTileState();
}

class _PhotoTileState extends State<PhotoTile> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = getMediaQuerySize(context);
    final theme = getThemeDataOfContext(context);
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PhotoDetailsPage(photo: widget.photo)));
        },
        child: Container(
            child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: Key(widget.photo?.id.toString() ?? ''),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.photo?.src?.large ?? '',
                    width: screenSize.width * 0.3,
                    fit: BoxFit.fill,
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
                widget.photo?.photographer ?? '',
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
