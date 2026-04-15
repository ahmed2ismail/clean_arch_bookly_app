import 'package:clean_arch_bookly_app/Core/utils/api_service.dart';
import 'package:clean_arch_bookly_app/Core/utils/functions/save_books_localy.dart';
import 'package:clean_arch_bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/constants.dart';

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
    // هنا انا جبت البيانات من ال api وبعدين حولتها لقائمة من ال BookEntity باستخدام ال getBooksList اللي بتحول ال json اللي جايلي من ال api لقائمة من ال BookEntity وبعدين خزنتها في ال hive box اللي اسمه kFeaturedBox عشان اقدر اجيبها تاني لما احتاجها بدون ما احتاج اتصل بال api مرة تانية 
    saveBooksDataLocaly(data, boxName: kFeaturedBox);
    return getBooksList(data);
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
    final data = await apiService.getRequest(
      endpoint: 'volumes?Filtering=free-ebooks&q=programming&Sorting=newest',
    );
    saveBooksDataLocaly(data, boxName: kNewestBox);
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
