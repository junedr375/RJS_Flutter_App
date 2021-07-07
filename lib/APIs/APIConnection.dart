import 'dart:convert';

import 'package:artapp/models/PhotoModel.dart';
import 'package:artapp/models/VideoModel.dart';

import 'package:http/http.dart' as http;

class APIConnection {
  static String apiAuthKeys =
      '563492ad6f91700001000001a60a1a4ddf2846c6b3aaa7028ce63c63';
  static String baseUrl = 'https://api.pexels.com/v1/';

  static Map<String, String> header = {'Authorization': apiAuthKeys};

  static Future<List<Photo>> getPhotosFromAPI(int pageNumber) async {
    var response = await http.get(
        Uri.parse(
            baseUrl + 'curated?page=' + pageNumber.toString() + '&per_page=12'),
        headers: header);

    return photoFromJson(response.body);
  }

  static Future<List<Video>> getVideosFromAPI(int pageNumber) async {
    var response = await http.get(
        Uri.parse(baseUrl +
            '/videos/popular?per_page=' +
            pageNumber.toString() +
            '&per_page=12'),
        headers: header);

    return videoFromJson(response.body);
  }
}
