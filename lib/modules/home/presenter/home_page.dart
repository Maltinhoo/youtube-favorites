import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favoritos/modules/home/presenter/widgets/video_tile.dart';

import '../../search/presenter/data_search.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: SizedBox(
          height: 25,
          child: Image.asset('assets/images/youtube_logo.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [
          const Align(
            alignment: Alignment.center,
            child: Text('0'),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star),
          ),
          IconButton(
            onPressed: () async {
              String result = await showSearch(
                    context: context,
                    delegate: DataSearch(),
                  ) ??
                  '';
              if (result.isNotEmpty) {
                BlocProvider.getBloc<HomeBloc>().inSearch.add(result);
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
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
