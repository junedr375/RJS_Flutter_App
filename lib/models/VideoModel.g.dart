// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VideoModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoAdapter extends TypeAdapter<Video> {
  @override
  final int typeId = 1;

  @override
  Video read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Video(
      id: fields[1] as int?,
      width: fields[2] as int?,
      height: fields[3] as int?,
      url: fields[4] as String?,
      image: fields[5] as String?,
      duration: fields[6] as int?,
      user: fields[7] as User?,
      videoFiles: (fields[8] as List?)?.cast<VideoFile>(),
      videoPictures: (fields[9] as List?)?.cast<VideoPicture>(),
    );
  }

  @override
  void write(BinaryWriter writer, Video obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.width)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.duration)
      ..writeByte(7)
      ..write(obj.user)
      ..writeByte(8)
      ..write(obj.videoFiles)
      ..writeByte(9)
      ..write(obj.videoPictures);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 3;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int?,
      name: fields[1] as String?,
      url: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoFileAdapter extends TypeAdapter<VideoFile> {
  @override
  final int typeId = 4;

  @override
  VideoFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoFile(
      id: fields[0] as int?,
      quality: fields[1] as String?,
      fileType: fields[2] as String?,
      width: fields[3] as int?,
      height: fields[4] as int?,
      link: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VideoFile obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.quality)
      ..writeByte(2)
      ..write(obj.fileType)
      ..writeByte(3)
      ..write(obj.width)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.link);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoFileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoPictureAdapter extends TypeAdapter<VideoPicture> {
  @override
  final int typeId = 5;

  @override
  VideoPicture read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoPicture(
      id: fields[0] as int?,
      picture: fields[1] as String?,
      nr: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, VideoPicture obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.picture)
      ..writeByte(2)
      ..write(obj.nr);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoPictureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
