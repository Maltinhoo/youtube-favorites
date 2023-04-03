import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favoritos/modules/home/presenter/widgets/home_app_bar.dart';
import 'package:youtube_favoritos/modules/home/presenter/widgets/video_tile.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: HomeAppBar(),
      ),
      body: StreamBuilder(
          initialData: const [],
          stream: BlocProvider.getBloc<HomeBloc>().outVideos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data.length + 1,
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return VideoTile(video: snapshot.data[index]);
                  } else if (index > 1) {
                    BlocProvider.getBloc<HomeBloc>().inSearch.add('');
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
