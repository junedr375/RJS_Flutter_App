import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';

class NoContentScreen extends StatefulWidget {
  final String contentType;
  const NoContentScreen({Key? key, this.contentType = ''}) : super(key: key);

  @override
  _NoContentScreenState createState() => _NoContentScreenState();
}

class _NoContentScreenState extends State<NoContentScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = getThemeDataOfContext(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Text(
          'The is no favourite items of type ${widget.contentType}, Please add some.',
          style: theme.textTheme.headline1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
