import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favoritos/core/inject.dart';

import 'modules/favorite/presenter/bloc/favorite_bloc.dart';
import 'modules/home/presenter/bloc/home_bloc.dart';
import 'modules/home/presenter/home_page.dart';

void main() async {
  Injector.init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => HomeBloc(
              getIt(),
              getIt(),
            )),
        Bloc((i) => FavoriteBloc())
      ],
      dependencies: const [],
      child: const MaterialApp(
        title: 'Youtube Bloc Pattern',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
