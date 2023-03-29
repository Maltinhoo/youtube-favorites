import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:youtube_favoritos/utils/http_client/http_client.dart';

import '../../infra/datasources/search_datasource.dart';

class SearchDataSourceImp implements SearchDataSource {
  final HttpService client;

  SearchDataSourceImp(this.client);

  @override
  Future<Either<Exception, List<String>>> getSuggestions(String search) async {
    final response = await client.get(
        'http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json');
    if (response.statusCode == 200) {
      final suggestions = (jsonDecode(response.body)[1] as List).map((e) {
        return e[0] as String;
      }).toList();
      return Right(suggestions);
    } else {
      throw Exception('Failed to load suggestions');
    }
  }
}
