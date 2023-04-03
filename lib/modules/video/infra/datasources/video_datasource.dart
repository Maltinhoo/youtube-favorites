import 'package:dartz/dartz.dart';

import '../models/video_model.dart';

abstract class VideoDataSource {
  Future<Either<Exception, List<VideoModel>>> search(String search);
  Future<Either<Exception, List<VideoModel>>> nextPage();
}
