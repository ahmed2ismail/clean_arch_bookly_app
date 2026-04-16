import 'package:clean_arch_bookly_app/Core/di/injection_container.dart' as di;
import 'package:clean_arch_bookly_app/Core/utils/app_router.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:clean_arch_bookly_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // 1. تهيئة Hive
  await Hive.initFlutter();

  // 2. تسجيل ال TypeAdapter الخاص ب BookEntity
  Hive.registerAdapter(BookEntityAdapter());

  // 3. فتح "صندوق" لتخزين المهام. الصندوق يشبه الجدول في SQL.
  // هنا بنفتح صندوق باسم kFeaturedBox لتخزين الكتب المميزة وصندوق تاني باسم kNewestBox لتخزين الكتب الجديدة
  await Hive.openBox<BookEntity>(kFeaturedBox);
  await Hive.openBox<BookEntity>(kNewestBox);

  // تهيئة ال Dependency Injection
  await di.init();

  runApp(const CleanArchBooklyApp());
}

class CleanArchBooklyApp extends StatelessWidget {
  const CleanArchBooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              di.sl<FeaturedBooksCubit>()..fetchFeaturedBooks(),
        ),
        BlocProvider(
          create: (context) => di.sl<NewestBooksCubit>()..fetchNewestBooks(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        title: 'Bookly App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme: GoogleFonts.montserratTextTheme(
            ThemeData.dark().textTheme,
          ),
        ),
      ),
    );
  }
}
