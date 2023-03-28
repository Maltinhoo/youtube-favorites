import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:youtube_favoritos/modules/video/domain/usecases/search_video_usecase.dart';
import 'package:youtube_favoritos/modules/video/infra/datasources/video_datasource.dart';

import '../modules/video/domain/repositories/video_repository.dart';
import '../modules/video/external/utils/http_client/http_client.dart';
import '../modules/video/external/video_http/video_http_imp.dart';
import '../modules/video/infra/repositories/video_repository_imp.dart';

GetIt getIt = GetIt.I;

class Injector {
  static void init() {
    //utils
    getIt.registerFactory<HttpClient>(() => HttpClientImp(Client()));

    // init all datasources
    getIt.registerFactory<VideoDataSource>(() => VideoDataSourceImp(getIt()));

    // init all repositories
    getIt.registerFactory<VideoRepository>(() => VideoRepositoryImp(getIt()));

    // init all usecases
    getIt.registerFactory<SearchVideoUseCase>(
        () => SearchVideoUseCaseImp(getIt()));
  }
}
