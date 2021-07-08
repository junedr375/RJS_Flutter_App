import 'package:artapp/pages/home/DetailHome.dart';
import 'package:artapp/pages/home/Drawer.dart';
import 'package:artapp/widgets/NoInternetScreen.dart';
import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Main Home Screen Here Drawer is implemented with Stack
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInternet = false;

  //For setting Up Connection
  void _getConnectionStatus(ConnectivityResult con) {
    print(con);
    setState(() {
      switch (con) {
        case ConnectivityResult.mobile:
          isInternet = true;

          break;
        case ConnectivityResult.wifi:
          isInternet = true;
          break;
        case ConnectivityResult.none:
          isInternet = false;
          break;
        default:
          isInternet = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final con = Provider.of<ConnectivityResult>(context);
    Size screenSize = getMediaQuerySize(context);
    double mainAxisHeight = getMainAxisHeight(context);
    final theme = getThemeDataOfContext(context);

    _getConnectionStatus(con); // To get Connection Status and updating the UI

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
