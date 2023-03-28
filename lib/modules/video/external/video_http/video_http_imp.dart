import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:youtube_favoritos/modules/video/external/utils/http_client/http_client.dart';
import 'package:youtube_favoritos/modules/video/infra/models/video_model.dart';

import '../../../../api.dart';
import '../../infra/datasources/video_datasource.dart';

class VideoDataSourceImp implements VideoDataSource {
  final HttpClient client;

  VideoDataSourceImp(this.client);

  @override
  Future<Either<Exception, List<VideoModel>>> search(String search) async {
    Response response = await client.get(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10');

    final videos = (jsonDecode(response.body)['items'] as List)
        .map((video) => VideoModel.fromJson(video))
        .toList();
    return Right(videos);
  }
}
