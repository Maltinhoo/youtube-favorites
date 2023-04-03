
import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_favoritos/modules/video/domain/entities/video_entity.dart';
import 'package:youtube_favoritos/modules/video/domain/usecases/next_page_usecase.dart';
import 'package:youtube_favoritos/modules/video/domain/usecases/search_video_usecase.dart';

class HomeBloc extends BlocBase {
  final SearchVideoUseCase searchVideoUseCase;
  final NextPageUseCase nextPageUseCase;

  final StreamController _videosController = StreamController();
  final StreamController _searchController = StreamController();

  List<VideoEntity> videos = [];

  Stream get outVideos => _videosController.stream;
  Sink get inSearch => _searchController.sink;

  HomeBloc(
    this.searchVideoUseCase,
    this.nextPageUseCase,
  ) {
    _searchController.stream.listen((event) {
      _search(event);
    });
  }

  void _search(String search) async {
    if (search.isNotEmpty) {
      _videosController.sink.add([]);
      final result = await searchVideoUseCase(search);
      result.fold((l) => print(l), (r) => videos = r);
    } else {
      final result = await nextPageUseCase();
      result.fold((l) => print(l), (r) => videos += r);
    }
    _videosController.sink.add(videos);
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }
}
