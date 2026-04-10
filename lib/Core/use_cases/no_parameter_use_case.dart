import 'package:clean_arch_bookly_app/Core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<T> {
  Future<Either<Failure, T>> call();
}