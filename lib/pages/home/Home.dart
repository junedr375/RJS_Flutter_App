import 'package:artapp/pages/home/DetailHome.dart';
import 'package:artapp/pages/home/Drawer.dart';
import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = getMediaQuerySize(context);
    double mainAxisHeight = getMainAxisHeight(context);
    final theme = getThemeDataOfContext(context);

    return SafeArea(
        child: Scaffold(
      body: Container(
        height: mainAxisHeight,
        width: screenSize.width,
        child: Stack(
          children: [MyDrawer(), Home()],
        ),
      ),
    ));
  }
}
