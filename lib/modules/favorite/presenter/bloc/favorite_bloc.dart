import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_favoritos/modules/video/domain/entities/video_entity.dart';

import '../../../video/infra/models/video_model.dart';

class FavoriteBloc implements BlocBase {
  Map<String, VideoEntity> _favorites = {};

  final StreamController<Map<String, VideoEntity>> _favController =
      StreamController<Map<String, VideoEntity>>.broadcast();

  Stream<Map<String, VideoEntity>> get outFav => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains('favorites')) {
        _favorites =
            jsonDecode(prefs.getString('favorites') ?? '').map((key, value) {
          return MapEntry(key, VideoModel.fromJson(value));
        }).cast<String, VideoModel>();

        _favController.add(_favorites);
      }
    });
  }

  void toggleFavorite(VideoEntity video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }
    _favController.sink.add(_favorites);

    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('favorites', jsonEncode(_favorites));
    });
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
