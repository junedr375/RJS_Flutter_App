import 'package:artapp/APIs/APIConnection.dart';
import 'package:artapp/models/PhotoModel.dart';
import 'package:artapp/pages/DetailScreens/PhotoDetailPage.dart';
import 'package:artapp/widgets/Loaders.dart';
import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';

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
                    widget.photo?.src?.portrait ?? '',
                    width: screenSize.width * 0.3,
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

class PhotoListTile extends StatefulWidget {
  const PhotoListTile({Key? key}) : super(key: key);

  @override
  _PhotoListTileState createState() => _PhotoListTileState();
}

class _PhotoListTileState extends State<PhotoListTile> {
  List<Photo> photosList = [];
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
    photosList = await APIConnection.getPhotosFromAPI(1);
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

    List<Photo> temList = await APIConnection.getPhotosFromAPI(pagedIndex);
    if (mounted) {
      setState(() {
        photosList.addAll(temList);
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
                    itemCount: photosList.length,
                    itemBuilder: (BuildContext context, int indexChild) {
                      Photo photo = photosList[indexChild];
                      return PhotoTile(
                        photo: photo,
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
