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
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'No Internet Connection\nPlease Check your Connection\nand Try again.',
          style: themeData.textTheme.headline3,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
