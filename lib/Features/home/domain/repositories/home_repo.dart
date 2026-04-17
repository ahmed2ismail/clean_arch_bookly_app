import 'package:clean_arch_bookly_app/Core/error/failures.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BookEntity>>> getFeaturedBooks({int pageNumber = 0});
  Future<Either<Failure, List<BookEntity>>> getNewestBooks({int pageNumber = 0});
}
