import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/book_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewestBooksListView extends StatefulWidget {
  const NewestBooksListView({super.key, required this.books});

  final List<BookEntity> books;

  @override
  State<NewestBooksListView> createState() => _NewestBooksListViewState();
}

class _NewestBooksListViewState extends State<NewestBooksListView> {
  late final ScrollController _scrollController;
  int nextPageNumber = 1; // بنبدأ من الصفحة الثانية عشان الصفحة الأولى جايانا في البداية مع البيانات الأولية
  late bool isLoading = false; // متغير بسيط عشان يمنع استدعاءات متكررة للـ Cubit لما المستخدم يوصل لنهاية القائمة


@override
  initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

@override
  dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // بنفحص لو المستخدم وصل لـ 70% من نهاية القائمة
    if (_scrollController.position.pixels >=
        0.7 * _scrollController.position.maxScrollExtent) {
      // بنستدعي الـ Cubit عشان يجيب الصفحة التالية من الكتب
      // لوجيك يمنع استدعاءات متكررة
      if (!isLoading) {
        isLoading = true; // بنغير الحالة عشان نمنع استدعاءات متكررة
      BlocProvider.of<NewestBooksCubit>(context).fetchNewestBooks();
        // nextPageNumber++; // بنزود رقم الصفحة عشان المرة الجاية نجيب اللي بعدها
        isLoading = false; // بنرجع الحالة عشان نسمح بطلبات جديدة
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      physics:
          const NeverScrollableScrollPhysics(), // بمعني ميبقاش فيه scroll خالص
      padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: BookListViewItem(imageUrl: widget.books[index].imageUrl ?? ''),
      ),
      itemCount: widget.books.length,
    );
  }
}
