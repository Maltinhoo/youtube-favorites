import 'package:dartz/dartz.dart';

import '../../domain/repositories/search_repository.dart';
import '../datasources/search_datasource.dart';

class SearchRepositoryImp implements SearchRepository {
  final SearchDataSource dataSource;

  SearchRepositoryImp(this.dataSource);

  @override
  Future<Either<Exception, List<String>>> getSuggestions(String search) {
    return dataSource.getSuggestions(search);
  }
}
