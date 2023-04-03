import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:youtube_favoritos/modules/search/domain/usecases/get_suggestions_usecase.dart';
import 'package:youtube_favoritos/modules/search/infra/datasources/search_datasource.dart';
import 'package:youtube_favoritos/modules/video/domain/usecases/next_page_usecase.dart';
import 'package:youtube_favoritos/modules/video/domain/usecases/search_video_usecase.dart';
import 'package:youtube_favoritos/modules/video/infra/datasources/video_datasource.dart';

import '../modules/favorite/presenter/bloc/favorite_bloc.dart';
import '../modules/home/presenter/bloc/home_bloc.dart';
import '../modules/search/domain/repositories/search_repository.dart';
import '../modules/search/external/search_http/search_http_imp.dart';
import '../modules/search/infra/repositories/search_repository_imp.dart';
import '../modules/video/domain/repositories/video_repository.dart';
import '../modules/video/external/video_http/video_http_imp.dart';
import '../modules/video/infra/repositories/video_repository_imp.dart';
import '../utils/http_client/http_client.dart';

GetIt getIt = GetIt.I;

class Injector {
  static void init() {
    //utils
    getIt.registerFactory<HttpService>(() => HttpServiceImp(Client()));

    // init all datasources
    getIt.registerFactory<VideoDataSource>(() => VideoDataSourceImp(getIt()));
    getIt.registerFactory<SearchDataSource>(() => SearchDataSourceImp(getIt()));

    // init all repositories
    getIt.registerFactory<VideoRepository>(() => VideoRepositoryImp(getIt()));
    getIt.registerFactory<SearchRepository>(() => SearchRepositoryImp(getIt()));

    // init all usecases
    getIt.registerFactory<SearchVideoUseCase>(
        () => SearchVideoUseCaseImp(getIt()));
    getIt.registerFactory<GetSuggestionsUseCase>(
        () => GetSuggestionsUseCaseImp(getIt()));
    getIt.registerFactory<NextPageUseCase>(() => NextPageUseCaseImp(getIt()));

    // init all blocs
    getIt.registerFactory<HomeBloc>(() => HomeBloc(
          getIt(),
          getIt(),
        ));
    getIt.registerFactory<FavoriteBloc>(() => FavoriteBloc());
  }
}
