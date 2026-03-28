import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/custom_book_details_appbar.dart';
import 'package:flutter/material.dart';
import 'books_details_section.dart';
import 'similar_books_section.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody:
              false, // عشان لو المحتوي بتاع ال Column اكبر من المساحة المتاحة في ال screen يفضل فيه scroll، ولو اقل من المساحة المتاحة في ال screen يبقي مفيش scroll خالص
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
            child: Column(
              children: [
                CustomBookDetailsAppBar(),
                BookDetailsSection(),
                Expanded(child: SizedBox(height: 50)),
                SimilarBooksSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}