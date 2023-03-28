import 'package:dartz/dartz.dart';
import 'package:youtube_favoritos/modules/video/domain/entities/video_entity.dart';

import '../../domain/repositories/video_repository.dart';
import '../datasources/video_datasource.dart';

class VideoRepositoryImp implements VideoRepository {
  final VideoDataSource dataSource;

  VideoRepositoryImp(this.dataSource);

  @override
  Future<Either<Exception, List<VideoEntity>>> search(String search) async {
    return await dataSource.search(search);
  }
}
