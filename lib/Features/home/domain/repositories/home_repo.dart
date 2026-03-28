import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';

abstract class HomeRepo {
  Future<List<BookEntity>> getFeaturedBooks();
  Future<List<BookEntity>> getBestSellerBooks();
}