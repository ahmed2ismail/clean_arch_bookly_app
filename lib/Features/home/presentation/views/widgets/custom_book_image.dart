import 'package:clean_arch_bookly_app/Core/utils/assets.dart';
import 'package:flutter/material.dart';

class CustomBookImage extends StatelessWidget {
  const CustomBookImage({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      // AspectRatio widget: بتستخدم لضبط نسبة الطول والعرض وبتطنش ال width, height بتاع ال child
      // يعني انا بقولها انا هديكي قيمة واحدة وعايزك تظبطي القيمة التانية علي اساسها
      aspectRatio: 2.6 / 4,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          image: const DecorationImage(
            image: AssetImage(AssetsData.testImage),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
