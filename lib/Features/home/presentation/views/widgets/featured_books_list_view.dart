import 'dart:ui';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FuturedBooksListView extends StatefulWidget {
  const FuturedBooksListView({super.key, required this.books});

  final List<BookEntity> books;

  @override
  State<FuturedBooksListView> createState() => _FuturedBooksListViewState();
}

class _FuturedBooksListViewState extends State<FuturedBooksListView> {
  late final ScrollController _scrollController;
  int nextPageNumber = 1; // بنبدأ من الصفحة الثانية عشان الصفحة الأولى جايانا في البداية مع البيانات الأولية
  late bool isLoading = false; // متغير بسيط عشان يمنع استدعاءات متكررة للـ Cubit لما المستخدم يوصل لنهاية القائمة

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
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
      if (!isLoading) { // بنفحص لو مفيش طلب جاي حاليا من قبل المستخدم
        isLoading = true; // بنغير الحالة عشان نمنع استدعاءات متكررة
        BlocProvider.of<FeaturedBooksCubit>(context).fetchFeaturedBooks(pageNumber: nextPageNumber++);
        // nextPageNumber++; // بنزود رقم الصفحة عشان المرة الجاية نجيب اللي بعدها
        isLoading = false; // بنرجع الحالة عشان نسمح بطلبات جديدة
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      // ال AspectRatio هتظبط ابعاد الصورة علي اساس ابعاد ال SizedBox والصورة هتبقي Responsible و مظبوطة علي اي جهاز
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: ListView.builder(
          controller: _scrollController, // بنربط الـ controller بالـ ListView
          scrollDirection: Axis.horizontal,
          itemCount: widget.books.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomBookImage(
              imageUrl: widget.books[index].imageUrl ?? '',
            ),
          ),
        ),
      ),
    );
  }
}
