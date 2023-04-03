import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_favoritos/modules/video/domain/entities/video_entity.dart';
import 'package:youtube_favoritos/modules/video/presenter/widgets/video_description.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../favorite/presenter/bloc/favorite_bloc.dart';

class VideoPlayer extends StatelessWidget {
  final VideoEntity video;

  const VideoPlayer({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();
    final youtubeController = YoutubePlayerController(initialVideoId: video.id);

    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: youtubeController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.white70,
        ),
        aspectRatio: 16.0 / 9.0,
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black87,
          actions: [
            StreamBuilder<Map<String, VideoEntity>>(
              stream: bloc.outFav,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return IconButton(
                    icon: Icon(
                      snapshot.data!.containsKey(video.id)
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      bloc.toggleFavorite(video);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            player,
            VideoDescription(video: video),
          ],
        ),
      ),
    );
  }
}
