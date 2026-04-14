import 'package:clean_arch_bookly_app/Core/utils/api_service.dart';
import 'package:clean_arch_bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';

abstract class HomeRemoteDataSource {
  // النوع هنا هو Future<List<BookEntity>> من غير Either عشان احنا بنرجع List of BookEntity يعني قائمة من الكتب وكل كتاب هو عبارة عن BookEntity فقط ومش بنتعامل مع الاخطاء هنا عشان دي لجلب البيانات فقط اما التعامل مع الاخطاء فدي في ال impl بتاع ال homeRepo لان ال homeRepo هو اللي بيتعامل مع ال data sources كلها سواء كانت remote او local وبيتعامل مع الاخطاء اللي ممكن تحصل في اي منهم وبيرجع النتيجة اللي جايه من ال data source سواء كانت بيانات او خطأ للي فوق اللي هو ال use case
  Future<List<BookEntity>> fetchFeaturedBooks();
  Future<List<BookEntity>> fetchNewestBooks();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<BookEntity>> fetchFeaturedBooks() {
    // TODO: implement fetchFeaturedBooks
    throw UnimplementedError();
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks() {
    // TODO: implement fetchNewestBooks
    throw UnimplementedError();
  }

}
