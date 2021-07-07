import 'dart:async';

import 'package:artapp/pages/Login/loginPage.dart';
import 'package:artapp/pages/home/Home.dart';
import 'package:artapp/utils/AppThemeData.dart';
import 'package:artapp/widgets/NoInternetScreen.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isInternet = true;

  StreamSubscription<ConnectivityResult>? subscription;

  @override
  void initState() {
    checkConnectivityHere();
    openInternetSubscription();
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void openInternetSubscription() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result.index == 0 || result.index == 1) {
        if (mounted)
          setState(() {
            isInternet = true;
          });
        Future.delayed(Duration(milliseconds: 100), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomePage(),
            ),
          );
        });
      } else {
        if (mounted)
          setState(() {
            isInternet = false;
          });
      }
    });
  }

  void checkConnectivityHere() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (mounted)
        setState(() {
          isInternet = true;
        });
    } else {
      if (mounted)
        setState(() {
          isInternet = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Artitia',
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        theme: appLightTheme(),
        darkTheme: appDarkTheme(),
        home: isInternet ? HomePage() : NoInternetConnection());
  }
}
