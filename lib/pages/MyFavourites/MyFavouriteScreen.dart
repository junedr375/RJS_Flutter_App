import 'package:artapp/Providers/PhotoFavouriteProvider.dart';
import 'package:artapp/Providers/VideoFavouriteProvider.dart';
import 'package:artapp/pages/home/Home.dart';
import 'package:artapp/pages/home/PhotoTile.dart';
import 'package:artapp/pages/home/VideoTile.dart';
import 'package:artapp/widgets/NoDataScreen.dart';
import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFavouriteScreen extends StatefulWidget {
  @override
  _MyFavouriteScreenState createState() => _MyFavouriteScreenState();
}

class _MyFavouriteScreenState extends State<MyFavouriteScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();

    super.dispose();
  }

  double xOffset = 0.0;
  double yOffset = 0.0;
  double scale = 1.0;

  bool isDrawerVisible = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = getMediaQuerySize(context);
    double mainAxisHeight = getMainAxisHeight(context);
    final theme = getThemeDataOfContext(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            Text(
              'My Favourites',
              style: theme.textTheme.headline1,
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 10),
          Expanded(child: tabSection()),
        ],
      ),
    );
  }

  Widget tabSection() {
    final theme = getThemeDataOfContext(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 40,
          child: TabBar(
            labelColor: theme.tabBarTheme.labelColor,
            controller: tabController,
            tabs: [
              Tab(
                child: Text(
                  'Photos',
                  style: theme.textTheme.headline2,
                ),
              ),
              Tab(
                child: Text(
                  'Videos',
                  style: theme.textTheme.headline2,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
            child: TabBarView(
          controller: tabController,
          children: [
            Consumer<PhotoFavouriteNotifier>(
                builder: (ctx, photoProvider, child) {
              return photoProvider.photoBox!.length != 0
                  ? PhotoListTile(
                      isFromLocal: true,
                    )
                  : NoContentScreen(
                      message: 'No Photos found\nadd some to your\nFavourite.',
                    );
            }),
            Consumer<VideoFavouriteNotifier>(
                builder: (ctx, photoProvider, child) {
              return photoProvider.videoBox!.length != 0
                  ? VideoListTile(
                      isFromLocal: true,
                    )
                  : NoContentScreen(
                      message: 'No Videos found\nadd some to your\nFavourite.',
                    );
            }),
          ],
        ))
      ],
    );
  }
}
