import 'package:artapp/Providers/PhotoFavouriteProvider.dart';
import 'package:artapp/models/PhotoModel.dart';
import 'package:artapp/utils/laucnThisUrl.dart';
import 'package:artapp/widgets/Loaders.dart';
import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PhotoDetailsPage extends StatefulWidget {
  final Photo? photo;
  const PhotoDetailsPage({Key? key, @required this.photo}) : super(key: key);

  @override
  _PhotoDetailsPageState createState() => _PhotoDetailsPageState();
}

class _PhotoDetailsPageState extends State<PhotoDetailsPage>
    with TickerProviderStateMixin {
  bool isFavourite = false;
  // late Animation favouriteAnimation;
  // late AnimationController animationController;
  @override
  void initState() {
    // animationController =
    //     AnimationController(duration: Duration(milliseconds: 700), vsync: this);

    // favouriteAnimation = Tween(begin: 0.0, end: -0.15).animate(
    //   CurvedAnimation(parent: animationController, curve: Curves.ease),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getMediaQuerySize(context);
    final theme = getThemeDataOfContext(context);
    return Scaffold(
      body: Column(
        children: [
          imageSection(),
          SizedBox(height: 10),
          Expanded(
            child: imageDetailSectionWidget(),
          ),
          SizedBox(height: 5)
        ],
      ),
    );
  }

  Widget imageDetailSectionWidget() {
    Size screenSize = getMediaQuerySize(context);
    final theme = getThemeDataOfContext(context);
    return Column(
      children: [
        InkWell(
            onTap: () async {
              String _url = widget.photo?.photographerUrl ?? '';
              launchThisUrl(_url);
            },
            child: Container(
              width: screenSize.width,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: screenSize.width * 0.5,
                decoration: BoxDecoration(
                    color: theme.highlightColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'View Profile',
                  style: theme.textTheme.headline4,
                ),
              ),
            )),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.ypesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      style: theme.textTheme.bodyText1,
                    )))),
      ],
    );
  }

  Widget imageSection() {
    Size screenSize = getMediaQuerySize(context);
    final theme = getThemeDataOfContext(context);
    return Stack(
      children: [
        ClipPath(
          clipper: MyClipper(),
          child: Hero(
              tag: Key(widget.photo?.id.toString() ?? ''),
              child: Container(
                height: screenSize.height * 0.65,
                width: screenSize.width,
                child: Image.network(
                  widget.photo?.src?.large ?? '',
                  width: screenSize.width * 0.3,
                  fit: BoxFit.fill,
                  loadingBuilder: imageLoader,
                ),
              )),
        ),
        Positioned(
            top: 30,
            child: Row(
              children: [
                SizedBox(width: 15),
                IconButton(
                    icon: Icon(Icons.arrow_back, size: 25),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            )),
        Positioned(
            bottom: 10,
            left: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: screenSize.width,
                    child: Text(
                      widget.photo?.photographer ?? '',
                      style: theme.textTheme.headline2,
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: 5,
                ),
              ],
            )),
        Positioned(
            right: 20,
            top: 30,
            child: Consumer<PhotoFavouriteNotifier>(
              builder: (ctx, provider, child) {
                return Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: theme.highlightColor),
                    child: GestureDetector(
                        onTap: () {
                          if (provider.photoBox!
                              .containsKey(widget.photo?.id)) {
                            provider.removePhotoToFavourite(
                                widget.photo ?? Photo());
                          } else {
                            provider
                                .addPhotoToFavourite(widget.photo ?? Photo());
                          }
                        },
                        child: provider.photoBox!.containsKey(widget.photo?.id)
                            ? Icon(
                                Icons.favorite,
                                size: 40,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border,
                                size: 40,
                              )));
              },
            )),
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset centerPoint = Offset(size.width / 2, size.height * 0.65 / 2);
    Offset leftCorner = Offset(40, size.height * 0.65);
    Offset rightCorner = Offset(size.width - 40, size.height);
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.65, size.height)
      ..quadraticBezierTo(rightCorner.dx - 20, rightCorner.dy - 20, size.width,
          size.height * 0.75)
      ..lineTo(size.width, size.height * 0.2)
      ..lineTo(size.width * 0.7, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
