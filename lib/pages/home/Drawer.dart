import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = getMediaQuerySize(context);
    double mainAxisHeight = getMainAxisHeight(context);
    final theme = getThemeDataOfContext(context);

    return Container(
      height: mainAxisHeight,
      width: screenSize.width,
      decoration: BoxDecoration(color: theme.primaryColor),
      child: ListView(
        children: [
          drawerCardWidget(name: 'My Favourites', onTap: () {}),
          drawerCardWidget(name: 'Manage Account', onTap: () {}),
          drawerCardWidget(name: 'Terms & Conditions', onTap: () {}),
          drawerCardWidget(name: 'Privacy Policy', onTap: () {}),
          drawerCardWidget(name: 'Security', onTap: () {}),
          drawerCardWidget(name: 'Settings', onTap: () {}),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget drawerCardWidget({String? name, Function()? onTap}) {
    Size screenSize = getMediaQuerySize(context);

    final theme = getThemeDataOfContext(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(
            top: 20, bottom: 20, right: screenSize.width * 0.35),
        decoration: BoxDecoration(
          color: theme.highlightColor,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 20,
                offset: Offset(2, 10))
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                name ?? '',
                style: theme.textTheme.headline6,
              ),
            )
          ],
        ),
      ),
    );
  }
}
