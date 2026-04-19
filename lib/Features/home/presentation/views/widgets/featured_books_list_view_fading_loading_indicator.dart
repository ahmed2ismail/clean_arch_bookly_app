import 'dart:ui';
import 'package:clean_arch_bookly_app/Core/widgets/custom_fading_widget.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/custom_book_image_loading_indicator.dart';
import 'package:flutter/material.dart';

class FeaturedBooksListViewFadingLoadingIndicator extends StatelessWidget {
  const FeaturedBooksListViewFadingLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFadingWidget(
      child: SizedBox(
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
            itemCount: 15,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomBookImageLoadingIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
