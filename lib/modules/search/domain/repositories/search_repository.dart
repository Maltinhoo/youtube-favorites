import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<Exception, List<String>>> getSuggestions(String search);
}
