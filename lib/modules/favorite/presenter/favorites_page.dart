import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favoritos/modules/favorite/presenter/bloc/favorite_bloc.dart';

import '../../video/domain/entities/video_entity.dart';
import '../../video/presenter/video_player.dart';

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
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VideoPlayer(video: e),
                          ),
                        );
                      },
                      onLongPress: () {
                        BlocProvider.getBloc<FavoriteBloc>().toggleFavorite(e);
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 50,
                            child: Image.network(e.thumb),
                          ),
                          Expanded(
                            child: Text(
                              e.title,
                              style: const TextStyle(color: Colors.white),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    );
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
