import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favoritos/modules/search/domain/usecases/get_suggestions_usecase.dart';

import '../../../core/inject.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((value) => close(context, query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder<Either<Exception, List<String>>>(
        future: GetSuggestionsUseCaseImp(getIt()).call(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.fold((l) => 0, (r) => r.length),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data!.fold((l) => '', (r) => r[index])),
                  leading: const Icon(Icons.play_arrow),
                  onTap: () {
                    close(context,
                        snapshot.data!.fold((l) => '', (r) => r[index]));
                  },
                );
              },
            );
          }
        },
      );
    }
  }
}
