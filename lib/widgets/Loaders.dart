import 'package:flutter/material.dart';

// To Show Loaders
Widget imageLoader(context, child, loadingProgress) {
  if (loadingProgress == null) return child;
  return Center(
      child: CircularProgressIndicator(
    backgroundColor: Colors.white,
    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
  ));
}

class CircularLoader extends StatefulWidget {
  final bool showBackgroud;
  const CircularLoader({Key? key, this.showBackgroud = true}) : super(key: key);

  @override
  _CircularLoaderState createState() => _CircularLoaderState();
}

class _CircularLoaderState extends State<CircularLoader> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Center(
        child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: widget.showBackgroud
                    ? themeData.accentColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: CircularProgressIndicator(
              backgroundColor: themeData.accentColor,
              valueColor: AlwaysStoppedAnimation<Color>(themeData.primaryColor),
            ))));
  }
}
