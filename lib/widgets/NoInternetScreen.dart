import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';

class NoInternetConnection extends StatefulWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  _NoInternetConnectionState createState() => _NoInternetConnectionState();
}

class _NoInternetConnectionState extends State<NoInternetConnection> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size screenSize = getMediaQuerySize(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: screenSize.height * 0.3,
            width: screenSize.width,
            child: Icon(
              Icons.no_cell_sharp,
              size: 80,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'No Internet Connection\nPlease Check your Connection\nand Try again.',
              style: themeData.textTheme.headline3,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
