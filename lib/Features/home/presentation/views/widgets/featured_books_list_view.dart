import 'dart:ui';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';

class FuturedBooksListView extends StatelessWidget {
  const FuturedBooksListView({super.key});

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
          scrollDirection: Axis.horizontal,
          itemCount: 20,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomBookImage(),
          ),
        ),
      ),
    );
  }
}
