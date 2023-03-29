import 'package:dartz/dartz.dart';

abstract class SearchDataSource {
  Future<Either<Exception, List<String>>> getSuggestions(String search);
}
