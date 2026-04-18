import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/constants.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  // ال type هنا هيكون list<BookEntity> من غير Future عشان دي بيانات محليه يعني مش بتاخد وقت في جلبها زي ال remote data source اللي بتاخد وقت في جلب البيانات من الانترنت فبنستخدم Future عشان نقدر نتعامل مع الوقت ده اما هنا فبنرجع البيانات مباشره من غير ما نحتاج نتعامل مع الوقت لانها متكيشة عندي في الجهاز
  // انا سميت هنا getLastFeaturedBooks و getLastNewestBooks عشان دي بتجيب اخر بيانات جتلي من ال api يعني اخر قائمة كتب جتلي من ال api سواء كانت featured او newest ودي بتكون مخزنة عندي في الجهاز فلو حصل اي مشكلة في الانترنت او اي حاجة تانية اقدر اجيب البيانات اللي عندي في الجهاز بدل ما اجيبها من ال api مرة تانية ودي بتكون مفيدة جدا في حالة ان المستخدم مش متصل بالانترنت او حصل اي مشكلة في الاتصال بالانترنت فبيقدر يشوف البيانات اللي عنده في الجهاز بدل ما يشوف رسالة خطأ او حاجة زي كده
  List<BookEntity> getLastFeaturedBooks({int pageNumber= 0});
  List<BookEntity> getLastNewestBooks({int pageNumber= 0});
  void saveFeaturedBooks(List<BookEntity> books);
  void saveNewestBooks(List<BookEntity> books);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  List<BookEntity> getLastFeaturedBooks({int pageNumber= 0}) {
    // هنا ممكن نستخدم اي طريقة لتخزين البيانات محليا زي shared preferences او hive او sqflite او اي طريقة تانية حسب ما يناسب التطبيق بتاعك
    // في المثال ده انا هستخدم hive لتخزين البيانات اللي جايالي من ال api محليا
    int startIndex = pageNumber * 10; // لو الصفحة الأولى هتبدأ من 0 ولو الصفحة الثانية هتبدأ من 10 وهكذا
    int endIndex = (pageNumber + 1) * 10; // لو الصفحة الأولى هتكون لغاية 10 ولو الصفحة الثانية هتكون لغاية 20 وهكذا
    var box = Hive.box<BookEntity>(kFeaturedBox);
    // لحل مشكلة ال out of range اللي ممكن تحصل لما احاول اعمل sublist من ال box وانا عندي بيانات اقل من ال startIndex او ال endIndex اللي انا عايز اعمل منهم sublist فبعمل check قبل ما اعمل ال sublist لو ال startIndex أو ال endIndex أكبر من طول البيانات اللي عندي في ال box يعني مفيش بيانات كفاية لعرض الصفحة دي فبترجعلي قائمة فاضية عشان ما يحصلش error لما احاول اعمل sublist من ال box
    var boxLength = box.values.length;
    if (startIndex >= boxLength || endIndex > boxLength) {
      // لو ال startIndex أو ال endIndex أكبر من طول البيانات اللي عندي في ال box، يعني مفيش بيانات كفاية لعرض الصفحة دي، فبترجعلي قائمة فاضية عشان ما يحصلش error لما احاول اعمل sublist من ال box
      return [];
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }

  @override
  List<BookEntity> getLastNewestBooks({int pageNumber= 0}) {
    // هنا انا بجيب البيانات اللي مخزنة عندي في ال hive box اللي اسمه kNewestBox وبحولها لقائمة من ال BookEntity وبيرجعها لي ال homeRepo اللي بيستخدمها في ال use case بتاعه عشان يقدر يعرضها في ال ui بتاعه
    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;
    var box = Hive.box<BookEntity>(kNewestBox);
    var boxLength = box.values.length;
    if (startIndex >= boxLength || endIndex > boxLength) {
      // لو ال startIndex أو ال endIndex أكبر من طول البيانات اللي عندي في ال box، يعني مفيش بيانات كفاية لعرض الصفحة دي، فبترجعلي قائمة فاضية عشان ما يحصلش error لما احاول اعمل sublist من ال box
      return [];
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }

  @override
  void saveFeaturedBooks(List<BookEntity> books) {
    var box = Hive.box<BookEntity>(kFeaturedBox);
    box.addAll(books);
  }

  @override
  void saveNewestBooks(List<BookEntity> books) {
    var box = Hive.box<BookEntity>(kNewestBox);
    box.addAll(books);
  }
}