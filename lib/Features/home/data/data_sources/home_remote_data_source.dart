import 'package:clean_arch_bookly_app/Core/utils/api_service.dart';
import 'package:clean_arch_bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';

abstract class HomeRemoteDataSource {
  // النوع هنا هو Future<List<BookEntity>> من غير Either عشان احنا بنرجع List of BookEntity يعني قائمة من الكتب وكل كتاب هو عبارة عن BookEntity فقط ومش بنتعامل مع الاخطاء هنا عشان دي لجلب البيانات فقط اما التعامل مع الاخطاء فدي في ال impl بتاع ال homeRepo لان ال homeRepo هو اللي بيتعامل مع ال data sources كلها سواء كانت remote او local وبيتعامل مع الاخطاء اللي ممكن تحصل في اي منهم وبيرجع النتيجة اللي جايه من ال data source سواء كانت بيانات او خطأ للي فوق اللي هو ال use case
  Future<List<BookEntity>> fetchFeaturedBooks();
  Future<List<BookEntity>> fetchNewestBooks();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<BookEntity>> fetchFeaturedBooks() async {
    final data = await apiService.getRequest(
      endpoint: 'volumes?Filtering=free-ebooks&q=programming',
    );
    return getBooksList(data);
  }


  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
    final data = await apiService.getRequest(
      endpoint: 'volumes?Filtering=free-ebooks&q=programming&Sorting=newest',
    );
    return getBooksList(data);
  }

    List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var item in data['items']) {
      books.add(BooksModel.fromJson(item));
    }
    return books;
  }
}
