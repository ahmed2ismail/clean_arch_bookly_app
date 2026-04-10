import 'package:clean_arch_bookly_app/Core/error/failures.dart';
import 'package:clean_arch_bookly_app/Core/use_cases/no_parameter_use_case.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';


class FetchFeaturedBooksUseCase implements UseCase<List<BookEntity>> {
  final HomeRepo homeRepo;

  FetchFeaturedBooksUseCase(this.homeRepo);

@override
  Future<Either<Failure, List<BookEntity>>> call() async {
    // هنا احنا بنقول ان ال call دي هتستقبل اي حاجة من ال parameters اللي احنا عايزينها يعني مثلا لو احنا عايزين نجيب الكتب اللي بتبدأ بحرف معين ممكن نعمل parameter اسمه startWith ونستخدمه هنا
    // او ممكن مثلا لو احنا هنت check علي permission قبل ما نجيب الكتب ممكن نعمل parameter اسمه permissionStatus ونستخدمه هنا
    // بس في الحالة دي احنا مش محتاجين اي parameters عشان كدا هنسيبها فاضية
    // وبعدين هنروح لل homeRepo ونقول له يجيبلي الكتب اللي هي featured books وبعدين هنرجع النتيجة اللي جايه من ال homeRepo
    return await homeRepo.getFeaturedBooks();
  }
}