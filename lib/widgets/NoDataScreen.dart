import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';

//No Data or Error Showing Screen
class NoContentScreen extends StatefulWidget {
  final String message;
  const NoContentScreen({Key? key, this.message = ''}) : super(key: key);

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
          widget.message,
          style: theme.textTheme.headline1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
