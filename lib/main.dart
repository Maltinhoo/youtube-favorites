import 'package:flutter/material.dart';
import 'package:youtube_favoritos/core/inject.dart';

import 'modules/home/presenter/home_page.dart';

void main() {
  Injector.init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Youtube Bloc Pattern',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
