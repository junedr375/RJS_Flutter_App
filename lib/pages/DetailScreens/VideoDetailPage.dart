import 'package:artapp/Providers/VideoFavouriteProvider.dart';
import 'package:artapp/models/PhotoModel.dart';
import 'package:artapp/models/VideoModel.dart';
import 'package:artapp/pages/VideoPlayer/VideoPlayerScreen.dart';
import 'package:artapp/utils/laucnThisUrl.dart';
import 'package:artapp/widgets/Loaders.dart';
import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class VideoDetailsPage extends StatefulWidget {
  final Video? video;
  const VideoDetailsPage({Key? key, @required this.video}) : super(key: key);

  @override
  _VideoDetailsPageState createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage>
    with TickerProviderStateMixin {
  int currentStarIndex = -1;
  bool isFavourite = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getMediaQuerySize(context);
    final theme = getThemeDataOfContext(context);
    return Scaffold(
      body: Column(
        children: [
          videoSection(),
          SizedBox(height: 10),
          videoDetailSectionWidget(),
          SizedBox(height: 5)
        ],
      ),
    );
  }

  Widget videoDetailSectionWidget() {
    Size screenSize = getMediaQuerySize(context);
    final theme = getThemeDataOfContext(context);
    return Expanded(
        child: Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      height: 40,
                      width: 200,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int starIndex) {
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  currentStarIndex = starIndex;
                                });
                              },
                              child: Container(
                                height: 38,
                                width: 38,
                                child: Icon(
                                  currentStarIndex >= starIndex
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: theme.highlightColor,
                                  size: 35,
                                ),
                              ));
                        },
                      )),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Duration: ' + (widget.video?.duration?.toString() ?? ' '),
                    style: theme.textTheme.headline4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
              child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.ypesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        style: theme.textTheme.bodyText1,
                      )))),
        ],
      ),
    ));
  }

  Widget videoSection() {
    Size screenSize = getMediaQuerySize(context);
    final theme = getThemeDataOfContext(context);
    return Stack(
      children: [
        Column(
          children: [
            ClipPath(
                clipper: MyClipper(),
                child: Hero(
                    tag: Key(widget.video?.id.toString() ?? ''),
                    child: CarouselSlider(
                        options: CarouselOptions(
                            autoPlay: true,
                            height: screenSize.height * 0.65,
                            viewportFraction: 1,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(seconds: 1)),
                        items: widget.video?.videoPictures?.map((videoImage) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                              height: screenSize.height * 0.65,
                              width: screenSize.width,
                              child: Image.network(
                                videoImage.picture ?? '',
                                width: screenSize.width * 0.3,
                                fit: BoxFit.fill,
                                loadingBuilder: imageLoader,
                              ),
                            );
                          });
                        }).toList()))),
            SizedBox(
              height: screenSize.height * 0.1,
            )
          ],
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
            bottom: screenSize.height * 0.1 + 10,
            left: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: screenSize.width,
                    child: Text(
                      widget.video?.user?.name ?? '',
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
            child: Consumer<VideoFavouriteNotifier>(
                builder: (ctx, provider, child) {
              return Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: theme.highlightColor),
                  child: GestureDetector(
                      onTap: () {
                        if (!provider.videoBox!
                            .containsKey(widget.video?.id ?? '')) {
                          provider.addVideoToFavourite(widget.video ?? Video());
                        } else {
                          provider.removeVideoFromFavourite(
                              widget.video ?? Video());
                        }
                      },
                      child:
                          provider.videoBox!.containsKey(widget.video?.id ?? '')
                              ? Icon(
                                  Icons.favorite,
                                  size: 40,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  size: 40,
                                )));
            })),
        Positioned(
          bottom: 10,
          left: 10,
          child: InkWell(
              onTap: () async {
                String _url = widget.video?.user?.url ?? '';
                launchThisUrl(_url);
              },
              child: Container(
                width: screenSize.width,
                alignment: Alignment.centerLeft,
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
        ),
        Positioned(
            right: 20,
            bottom: 40,
            child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.highlightColor,
                    boxShadow: [
                      BoxShadow(
                          color: theme.highlightColor.withOpacity(0.5),
                          offset: Offset(7, 7),
                          blurRadius: 15)
                    ]),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(
                                    video: widget.video,
                                  )));
                    },
                    child: Icon(
                      Icons.play_arrow,
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
    double radius = 20;
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
