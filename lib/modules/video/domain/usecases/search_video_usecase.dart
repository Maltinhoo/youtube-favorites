import 'package:dartz/dartz.dart';

import '../entities/video_entity.dart';
import '../repositories/video_repository.dart';

abstract class SearchVideoUseCase {
  Future<Either<Exception, List<VideoEntity>>> call(String search);
}

class SearchVideoUseCaseImp implements SearchVideoUseCase {
  final VideoRepository repository;

  SearchVideoUseCaseImp(this.repository);

  @override
  Future<Either<Exception, List<VideoEntity>>> call(String search) {
    return repository.search(search);
  }
}
