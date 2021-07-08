// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:artapp/Providers/PhotoFavouriteProvider.dart';
import 'package:artapp/models/PhotoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:artapp/main.dart' as appMain;
import 'package:hive/hive.dart';

void main() {
  appMain.main();
  test('when Photo is added to favourite PhotoBox it length will not be 0',
      () async {
    Map<String, dynamic> photoMap = {
      "id": 2014422,
      "width": 3024,
      "height": 3024,
      "url":
          "https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/",
      "photographer": "Joey Farina",
      "photographer_url": "https://www.pexels.com/@joey",
      "photographer_id": 680589,
      "avg_color": "#978E82",
      "src": {
        "original":
            "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg",
        "large2x":
            "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "large":
            "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
        "medium":
            "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=350",
        "small":
            "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=130",
        "portrait":
            "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
        "landscape":
            "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
        "tiny":
            "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
      }
    };

    PhotoFavouriteNotifier photoFavouriteNotifier =
        new PhotoFavouriteNotifier();

    photoFavouriteNotifier.addPhotoToFavourite(Photo.fromJson(photoMap));
    expect(true, photoFavouriteNotifier.photoBox!.length > 0);
  });

  test('When All Photo Remove Called for PhotoBox Its lenght will be 0', () {
    PhotoFavouriteNotifier photoFavouriteNotifier =
        new PhotoFavouriteNotifier();
    photoFavouriteNotifier.removeAllPhotoFromFavourite();
    expect(true, photoFavouriteNotifier.photoBox!.length == 0);
  });
}
