import 'dart:async';
import 'dart:io';

import 'package:artapp/Providers/DrawerProvider.dart';

import 'package:artapp/Providers/PhotoFavouriteProvider.dart';
import 'package:artapp/Providers/PhotoProvider.dart';
import 'package:artapp/Providers/VideoFavouriteProvider.dart';
import 'package:artapp/Providers/VideoProvider.dart';
import 'package:artapp/models/PhotoModel.dart';
import 'package:artapp/models/VideoModel.dart';
import 'package:artapp/pages/SplashScreen/SplashScreen.dart';

import 'package:artapp/pages/home/Home.dart';
import 'package:artapp/utils/AppThemeData.dart';
import 'package:artapp/widgets/NoInternetScreen.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent)); // For Transparent Notification Bar
  Directory directory = await getApplicationDocumentsDirectory();

  // Initializing Hive for local Database and Adding adapters
  Hive.init(directory.path);
  Hive.registerAdapter(PhotoAdapter());
  Hive.registerAdapter(VideoAdapter());
  Hive.registerAdapter(SrcAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(VideoFileAdapter());
  Hive.registerAdapter(VideoPictureAdapter());
  if (!Hive.isBoxOpen('photoBox')) await Hive.openBox<Photo>('photoBox');
  if (!Hive.isBoxOpen('videoBox')) await Hive.openBox<Video>('videoBox');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult connectivityResult = ConnectivityResult.mobile;
  @override
  void initState() {
    super.initState();
    getConnectivityResult();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getConnectivityResult() async {
    connectivityResult = await Connectivity().checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    // Setting app with Multi Provider with using Provider Package
    return MultiProvider(
        providers: [
          StreamProvider(
            create: (context) => Connectivity().onConnectivityChanged,
            initialData: connectivityResult,
          ),
          ChangeNotifierProvider(create: (context) => DrawerNotifier()),
          ChangeNotifierProvider(create: (context) => PhotoNotifier()),
          ChangeNotifierProvider(create: (context) => VideoNotifier()),
          ChangeNotifierProvider(create: (context) => PhotoFavouriteNotifier()),
          ChangeNotifierProvider(create: (context) => VideoFavouriteNotifier()),
        ],
        child: MaterialApp(
            title: 'Artitia',
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            theme: appLightTheme(),
            darkTheme: appDarkTheme(),
            home: SplashScreen()));
  }
}
