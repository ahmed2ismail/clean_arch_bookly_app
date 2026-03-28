import 'package:clean_arch_bookly_app/Core/error/failures.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class FetchBestNewestBooksUseCase {
  final HomeRepo homeRepo;

  FetchBestNewestBooksUseCase(this.homeRepo);

  Future<Either<Failure, List<BookEntity>>> getNewestBooksCall() async {
    return await homeRepo.getNewestBooks();
  }
}