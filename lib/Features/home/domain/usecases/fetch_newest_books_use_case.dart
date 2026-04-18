import 'package:clean_arch_bookly_app/Core/error/failures.dart';
import 'package:clean_arch_bookly_app/Core/use_cases/use_case.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class FetchBestNewestBooksUseCase implements UseCase<List<BookEntity>, int> {
  final HomeRepo homeRepo;

  FetchBestNewestBooksUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<BookEntity>>> call([int param = 0]) async {
    return await homeRepo.getNewestBooks(pageNumber: param);
  }
}
