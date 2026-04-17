import 'package:clean_arch_bookly_app/Core/error/failures.dart';
import 'package:clean_arch_bookly_app/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:clean_arch_bookly_app/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl implements HomeRepo {
  // هنا انا عملت ال HomeRepoImpl اللي هو ال implementation بتاع ال HomeRepo اللي هو ال repository اللي بيتعامل مع ال data sources كلها سواء كانت remote او local وبيتعامل مع الاخطاء اللي ممكن تحصل في اي منهم وبيرجع النتيجة اللي جايه من ال data source سواء كانت بيانات او خطأ للي فوق اللي هو ال use case وبيستخدم ال HomeRemoteDataSource عشان يجلب البيانات من الانترنت و ال HomeLocalDataSource عشان يجلب البيانات من الجهاز في حالة ان الانترنت مش شغال او حصل اي مشكلة في الاتصال بالانترنت فبيقدر يجيب البيانات اللي عنده في الجهاز بدل ما يشوف رسالة خطأ او حاجة زي كده
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });

  @override
  Future<Either<Failure, List<BookEntity>>> getFeaturedBooks({int pageNumber = 0}) async {
    try {
      // بجيب البيانات من ال local data source الاول عشان اشوف اذا كانت موجودة عندي في الجهاز ولا لا فلو كانت موجودة بستخدمها وارجعها للي فوق اللي هو ال use case اما لو ما كانتش موجودة بجيبها من ال remote data source وبعدين ارجعها للي فوق اللي هو ال use case
      // بس انا كده بجيب كل مرة نفس البيانات من ال local data source لانها متغيرتش يعني متحدثتش من ال remote data source
      List<BookEntity> books;
      books = homeLocalDataSource.getLastFeaturedBooks();
      if (books.isNotEmpty) {
        return right(books);
      }
      books = await homeRemoteDataSource.fetchFeaturedBooks();
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getNewestBooks({int pageNumber = 0}) async {
    try {
      List<BookEntity> books;
      books = homeLocalDataSource.getLastNewestBooks();
      if (books.isNotEmpty) {
        return right(books);
      }
      books = await homeRemoteDataSource.fetchNewestBooks();
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
