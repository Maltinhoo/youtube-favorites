import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../../video/domain/entities/video_entity.dart';
import '../../../video/presenter/video_player.dart';
import '../bloc/favorite_bloc.dart';

class FavoriteVideo extends StatelessWidget {
  final VideoEntity video;
  const FavoriteVideo({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoPlayer(video: video),
          ),
        );
      },
      onLongPress: () {
        BlocProvider.getBloc<FavoriteBloc>().toggleFavorite(video);
      },
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 50,
            child: Image.network(video.thumb),
          ),
          Expanded(
            child: Text(
              video.title,
              style: const TextStyle(color: Colors.white),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
