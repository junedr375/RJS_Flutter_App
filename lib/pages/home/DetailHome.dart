import 'package:artapp/Providers/DrawerProvider.dart';
import 'package:artapp/pages/home/PhotoTile.dart';
import 'package:artapp/pages/home/VideoTile.dart';
import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController tabController;

  //List<Photo> photosList = [];
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

  @override
  Widget build(BuildContext context) {
    Size screenSize = getMediaQuerySize(context);
    double mainAxisHeight = getMainAxisHeight(context);
    final theme = getThemeDataOfContext(context);
    return Consumer<DrawerNotifier>(builder: (ctx, drawerProvider, child) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
        transform: Matrix4.translationValues(
            drawerProvider.xOffset, drawerProvider.yOffset, 0.0)
          ..scale(drawerProvider.scale),
        height: mainAxisHeight,
        width: screenSize.width,
        decoration: drawerProvider.isDrawerVisible
            ? BoxDecoration(
                color: theme.backgroundColor,
                borderRadius: BorderRadius.circular(20))
            : BoxDecoration(color: theme.backgroundColor),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: drawerProvider.isDrawerVisible
                  ? BoxDecoration(
                      color: theme.backgroundColor,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(20)))
                  : BoxDecoration(color: theme.backgroundColor),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: drawerProvider.isDrawerVisible
                          ? Icon(
                              Icons.close,
                              size: 40,
                            )
                          : Icon(
                              Icons.menu,
                              size: 35,
                            ),
                      onPressed: () {
                        drawerProvider.toggleDrawerScreen(context);
                      }),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hello, Welcome Juned',
                        style: theme.textTheme.headline1,
                      )),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 20),
            searchSection(),
            SizedBox(height: 10),

            Expanded(child: tabSection()),

            //  tabSection()
            // Expanded(
            //   flex: ,
            //   child: tabSection(),
            // ),
          ],
        ),
      );
    });
  }

  Widget searchSection() {
    Size screenSize = getMediaQuerySize(context);
    final theme = getThemeDataOfContext(context);
    return Container(
      height: 40,
      width: screenSize.width,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: theme.dividerColor.withOpacity(0.3), width: 2)),
      child: Row(
        children: [
          Container(
              width: screenSize.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search here for any images or videos',
                    hintStyle: theme.textTheme.bodyText1),
              ))
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
            PhotoListTile(),
            VideoListTile(),
          ],
        ))
      ],
    );
  }

  // Widget appBarWidget() {
  //   final theme = getThemeDataOfContext(context);
  //   return Container(
  //     decoration: drawerProvider.isDrawerVisible
  //         ? BoxDecoration(
  //             color: theme.backgroundColor,
  //             borderRadius: BorderRadius.only(topLeft: Radius.circular(20)))
  //         : BoxDecoration(color: theme.backgroundColor),
  //     height: 50,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         IconButton(
  //             icon: isDrawerVisible
  //                 ? Icon(
  //                     Icons.close,
  //                     size: 40,
  //                   )
  //                 : Icon(
  //                     Icons.menu,
  //                     size: 35,
  //                   ),
  //             onPressed: () {
  //               if (isDrawerVisible) {
  //                 setState(() {
  //                   xOffset = 0.0;
  //                   yOffset = 0.0;
  //                   scale = 1.0;
  //                   isDrawerVisible = false;
  //                 });
  //               } else {
  //                 setState(() {
  //                   xOffset = MediaQuery.of(context).size.width * 0.70;
  //                   yOffset = 80.0;
  //                   scale = .8;
  //                   isDrawerVisible = true;
  //                 });
  //               }
  //             }),
  //         SizedBox(
  //           width: 20,
  //         ),
  //         Container(
  //             alignment: Alignment.centerLeft,
  //             child: Text(
  //               'Hello, Welcome Juned',
  //               style: theme.textTheme.headline1,
  //             )),
  //         Spacer(),
  //       ],
  //     ),
  //   );
  // /}
}
