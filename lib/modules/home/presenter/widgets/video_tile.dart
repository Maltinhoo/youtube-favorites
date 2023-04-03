import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favoritos/modules/video/domain/entities/video_entity.dart';
import 'package:youtube_favoritos/modules/video/infra/models/video_model.dart';

import '../../../favorite/presenter/bloc/favorite_bloc.dart';
import '../../../video/presenter/video_player.dart';

class VideoTile extends StatelessWidget {
  final VideoModel video;
  const VideoTile({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoPlayer(video: video),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(video.thumb, fit: BoxFit.cover),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          video.title,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          video.channel,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Map<String, VideoEntity>>(
                    stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return IconButton(
                          icon: Icon(snapshot.data!.containsKey(video.id)
                              ? Icons.star
                              : Icons.star_border),
                          color: Colors.white,
                          iconSize: 30,
                          onPressed: () {
                            BlocProvider.getBloc<FavoriteBloc>()
                                .toggleFavorite(video);
                          },
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
