import 'package:dartz/dartz.dart';

import '../entities/video_entity.dart';

abstract class VideoRepository {
  Future<Either<Exception, List<VideoEntity>>> search(String search);
}
