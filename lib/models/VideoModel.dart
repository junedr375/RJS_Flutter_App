// To parse this JSON data, do
//
//     final video = videoFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part 'VideoModel.g.dart';

List<Video> videoFromJson(String str) =>
    List<Video>.from(json.decode(str)['videos'].map((x) => Video.fromJson(x)));

String videoToJson(List<Video> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class Video {
  Video({
    this.id,
    this.width,
    this.height,
    this.url,
    this.image,
    this.duration,
    this.user,
    this.videoFiles,
    this.videoPictures,
  });
  @HiveField(1)
  int? id;
  @HiveField(2)
  int? width;
  @HiveField(3)
  int? height;
  @HiveField(4)
  String? url;
  @HiveField(5)
  String? image;
  @HiveField(6)
  int? duration;
  @HiveField(7)
  User? user;
  @HiveField(8)
  List<VideoFile>? videoFiles;
  @HiveField(9)
  List<VideoPicture>? videoPictures;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        image: json["image"],
        duration: json["duration"],
        user: User.fromJson(json["user"]),
        videoFiles: List<VideoFile>.from(
            json["video_files"].map((x) => VideoFile.fromJson(x))),
        videoPictures: List<VideoPicture>.from(
            json["video_pictures"].map((x) => VideoPicture.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "width": width,
        "height": height,
        "url": url,
        "image": image,
        "duration": duration,
        "user": user?.toJson(),
        "video_files": List<dynamic>.from(videoFiles!.map((x) => x.toJson())),
        "video_pictures":
            List<dynamic>.from(videoPictures!.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 3)
class User {
  User({
    this.id,
    this.name,
    this.url,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? url;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
      };
}

@HiveType(typeId: 4)
class VideoFile {
  VideoFile({
    this.id,
    this.quality,
    this.fileType,
    this.width,
    this.height,
    this.link,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? quality;
  @HiveField(2)
  String? fileType;
  @HiveField(3)
  int? width;
  @HiveField(4)
  int? height;
  @HiveField(5)
  String? link;

  factory VideoFile.fromJson(Map<String, dynamic> json) => VideoFile(
        id: json["id"],
        quality: json["quality"],
        fileType: json["file_type"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quality": quality,
        "file_type": fileType,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "link": link,
      };
}

@HiveType(typeId: 5)
class VideoPicture {
  VideoPicture({
    this.id,
    this.picture,
    this.nr,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? picture;
  @HiveField(2)
  int? nr;

  factory VideoPicture.fromJson(Map<String, dynamic> json) => VideoPicture(
        id: json["id"],
        picture: json["picture"],
        nr: json["nr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "picture": picture,
        "nr": nr,
      };
}
