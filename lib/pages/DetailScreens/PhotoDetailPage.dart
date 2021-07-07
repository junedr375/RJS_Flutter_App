import 'package:artapp/models/PhotoModel.dart';
import 'package:artapp/widgets/Loaders.dart';
import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';
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
          InkWell(
              onTap: () async {
                String _url = widget.photo?.photographerUrl ?? '';
                await canLaunch(_url)
                    ? await launch(_url)
                    : throw 'Could not launch $_url';
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
        ],
      ),
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
                // AnimatedIcon(
                //     icon: AnimatedIcons.arrow_menu, progress: )
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
            child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: theme.highlightColor),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavourite = !isFavourite;
                      });
                    },
                    child: isFavourite
                        ? Icon(
                            Icons.favorite,
                            size: 40,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border,
                            size: 40,
                          )))),
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
