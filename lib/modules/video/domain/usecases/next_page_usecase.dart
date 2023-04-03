import 'package:dartz/dartz.dart';

import '../entities/video_entity.dart';
import '../repositories/video_repository.dart';

abstract class NextPageUseCase {
  Future<Either<Exception, List<VideoEntity>>> call();
}

class NextPageUseCaseImp implements NextPageUseCase {
  final VideoRepository repository;

  NextPageUseCaseImp(this.repository);

  @override
  Future<Either<Exception, List<VideoEntity>>> call() {
    return repository.nextPage();
  }
}
