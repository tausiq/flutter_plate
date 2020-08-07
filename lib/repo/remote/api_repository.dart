import 'package:dartz/dartz.dart';

import 'failures.dart';

abstract class ApiRepository {
  Future<Either<Failure, int>> getValue();
}
