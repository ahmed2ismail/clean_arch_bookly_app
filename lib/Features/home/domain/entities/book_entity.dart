import 'package:hive/hive.dart';

// هنا انا عملت ال BookEntity كلاس بسيط جدا فيه الحقول اللي انا محتاجها في التطبيق بتاعي زي ال bookId و imageUrl و title و authorName و price و rating وكل حقل منهم معمول له HiveField عشان اقدر اخزنه في ال hive box بسهولة وبعدين عملت ال part 'book_entity.g.dart' عشان اقدر استخدم ال code generation اللي بيقدمه ال hive عشان يكتبلي الكود اللي بيحول ال BookEntity ل json والعكس بسهولة وبكده اقدر اخزن البيانات اللي جايالي من ال api محليا في الجهاز باستخدام ال hive واقدر اجيبها تاني لما احتاجها بدون ما احتاج اتصل بال api مرة تانية
// هنعمل ال typeAdapter:

part 'book_entity.g.dart';

@HiveType(typeId: 0) // ال typeId ده رقم مميز لكل كلاس انت بتعمله عشان ال hive يقدر يفرق بين الكلاسات المختلفة اللي انت بتسجلها في ال hive
class BookEntity {
  @HiveField(0) // ال HiveField ده بيحدد رقم الحقل في ال hive box عشان يقدر يخزنه ويجيبه بسهولة من ال hive box لما يحتاجه
  final String bookId;
  @HiveField(1)
  final String? imageUrl;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String? authorName;
  @HiveField(4)
  final num? price;
  @HiveField(5)
  final num? rating;

  BookEntity({
    required this.imageUrl,
    required this.title,
    required this.authorName,
    required this.price,
    required this.rating,
    required this.bookId,
  });
}
