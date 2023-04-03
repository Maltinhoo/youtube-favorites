import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../../favorite/presenter/bloc/favorite_bloc.dart';
import '../../../favorite/presenter/favorites_page.dart';
import '../../../search/presenter/data_search.dart';
import '../../../video/domain/entities/video_entity.dart';
import '../bloc/home_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SizedBox(
        height: 25,
        child: Image.asset('assets/images/youtube_logo.png'),
      ),
      elevation: 0,
      backgroundColor: Colors.black87,
      actions: [
        Align(
          alignment: Alignment.center,
          child: StreamBuilder<Map<String, VideoEntity>>(
              stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('${snapshot.data?.length ?? '0'}');
                } else {
                  return Container();
                }
              }),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const FavoritesPage()));
          },
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
    );
  }
}
