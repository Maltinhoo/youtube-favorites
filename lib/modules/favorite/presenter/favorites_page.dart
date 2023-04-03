import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favoritos/modules/favorite/presenter/bloc/favorite_bloc.dart';
import 'package:youtube_favoritos/modules/favorite/presenter/widgets/favorite_video.dart';

import '../../video/domain/entities/video_entity.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favoritos'),
          backgroundColor: Colors.black87,
        ),
        backgroundColor: Colors.black87,
        body: StreamBuilder<Map<String, VideoEntity>>(
            stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
            initialData: const {},
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.values.map((e) {
                    return FavoriteVideo(video: e);
                  }).toList(),
                );
              } else {
                return const Center(
                  child: Text(
                    'Nenhum vídeo favorito',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            }));
  }
}
