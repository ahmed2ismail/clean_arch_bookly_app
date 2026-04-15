import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/constants.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  // ال type هنا هيكون list<BookEntity> من غير Future عشان دي بيانات محليه يعني مش بتاخد وقت في جلبها زي ال remote data source اللي بتاخد وقت في جلب البيانات من الانترنت فبنستخدم Future عشان نقدر نتعامل مع الوقت ده اما هنا فبنرجع البيانات مباشره من غير ما نحتاج نتعامل مع الوقت لانها متكيشة عندي في الجهاز
  // انا سميت هنا getLastFeaturedBooks و getLastNewestBooks عشان دي بتجيب اخر بيانات جتلي من ال api يعني اخر قائمة كتب جتلي من ال api سواء كانت featured او newest ودي بتكون مخزنة عندي في الجهاز فلو حصل اي مشكلة في الانترنت او اي حاجة تانية اقدر اجيب البيانات اللي عندي في الجهاز بدل ما اجيبها من ال api مرة تانية ودي بتكون مفيدة جدا في حالة ان المستخدم مش متصل بالانترنت او حصل اي مشكلة في الاتصال بالانترنت فبيقدر يشوف البيانات اللي عنده في الجهاز بدل ما يشوف رسالة خطأ او حاجة زي كده
  List<BookEntity> getLastFeaturedBooks();
  List<BookEntity> getLastNewestBooks();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  List<BookEntity> getLastFeaturedBooks() {
    // هنا ممكن نستخدم اي طريقة لتخزين البيانات محليا زي shared preferences او hive او sqflite او اي طريقة تانية حسب ما يناسب التطبيق بتاعك
    // في المثال ده انا هستخدم hive لتخزين البيانات اللي جايالي من ال api محليا
    var box = Hive.box<BookEntity>(kFeaturedBox);
    return box.values.toList();
  }

  @override
  List<BookEntity> getLastNewestBooks() {
    // هنا انا بجيب البيانات اللي مخزنة عندي في ال hive box اللي اسمه kNewestBox وبحولها لقائمة من ال BookEntity وبيرجعها لي ال homeRepo اللي بيستخدمها في ال use case بتاعه عشان يقدر يعرضها في ال ui بتاعه
    var box = Hive.box<BookEntity>(kNewestBox);
    return box.values.toList();
  }
}