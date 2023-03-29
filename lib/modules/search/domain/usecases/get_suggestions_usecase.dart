import 'package:dartz/dartz.dart';

import '../repositories/search_repository.dart';

abstract class GetSuggestionsUseCase {
  Future<Either<Exception, List<String>>> call(String search);
}

class GetSuggestionsUseCaseImp implements GetSuggestionsUseCase {
  final SearchRepository repository;

  GetSuggestionsUseCaseImp(this.repository);

  @override
  Future<Either<Exception, List<String>>> call(String search) {
    return repository.getSuggestions(search);
  }
}
