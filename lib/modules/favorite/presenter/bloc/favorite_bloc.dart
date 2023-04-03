import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_favoritos/modules/video/domain/entities/video_entity.dart';

class FavoriteBloc implements BlocBase {
  final Map<String, VideoEntity> _favorites = {};

  final StreamController<Map<String, VideoEntity>> _favController =
      StreamController<Map<String, VideoEntity>>.broadcast();

  Stream<Map<String, VideoEntity>> get outFav => _favController.stream;

  void toggleFavorite(VideoEntity video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }
    _favController.sink.add(_favorites);
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {}

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
