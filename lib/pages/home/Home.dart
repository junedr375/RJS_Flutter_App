import 'package:artapp/pages/home/DetailHome.dart';
import 'package:artapp/pages/home/Drawer.dart';
import 'package:artapp/widgets/NoInternetScreen.dart';
import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInternet = false;
  void _getConnectionStatus(ConnectivityResult con) {
    print(con);
    setState(() {
      switch (con) {
        case ConnectivityResult.mobile:
          isInternet = true;
          // _connectivityType = 'Mobile';
          break;
        case ConnectivityResult.wifi:
          isInternet = true;
          //_connectivityType = 'Wifi';
          break;
        case ConnectivityResult.none:
          isInternet = false;
          //_connectivityType = 'None';
          break;
        default:
          isInternet = false;
        //_connectivityType = 'Unknown';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final con = Provider.of<ConnectivityResult>(context);
    Size screenSize = getMediaQuerySize(context);
    double mainAxisHeight = getMainAxisHeight(context);
    final theme = getThemeDataOfContext(context);

    _getConnectionStatus(con);

    return !isInternet
        ? NoInternetConnection()
        : SafeArea(
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
