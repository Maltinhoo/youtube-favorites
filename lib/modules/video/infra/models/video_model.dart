import 'package:youtube_favoritos/modules/video/domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    required super.id,
    required super.title,
    required super.thumb,
    required super.channel,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id')) {
      return VideoModel(
        id: json['id']['videoId'],
        title: json['snippet']['title'],
        thumb: json['snippet']['thumbnails']['high']['url'],
        channel: json['snippet']['channelTitle'],
      );
    } else {
      return VideoModel(
        id: json['videoId'],
        title: json['title'],
        thumb: json['thumb'],
        channel: json['channel'],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'videoId': id,
      'title': title,
      'thumb': thumb,
      'channel': channel,
    };
  }
}
