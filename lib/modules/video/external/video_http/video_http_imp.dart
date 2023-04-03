import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:youtube_favoritos/modules/video/infra/models/video_model.dart';
import 'package:youtube_favoritos/utils/http_client/http_client.dart';

import '../../../../api.dart';
import '../../infra/datasources/video_datasource.dart';

class VideoDataSourceImp implements VideoDataSource {
  final HttpService client;

  VideoDataSourceImp(this.client);

  String _nextToken = '';
  String _search = '';

  @override
  Future<Either<Exception, List<VideoModel>>> search(String search) async {
    _search = search;

    Response response = await client.get(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10');

    if (response.statusCode == 200) {
      _nextToken = jsonDecode(response.body)['nextPageToken'];

      final videos = (jsonDecode(response.body)['items'] as List)
          .map((video) => VideoModel.fromJson(video))
          .toList();

      return Right(videos);
    } else {
      throw Exception('Failed to load videos');
    }
  }

  @override
  Future<Either<Exception, List<VideoModel>>> nextPage() async {
    Response response = await client.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken");

    if (response.statusCode == 200) {
      final videos = (jsonDecode(response.body)['items'] as List)
          .map((video) => VideoModel.fromJson(video))
          .toList();

      return Right(videos);
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
