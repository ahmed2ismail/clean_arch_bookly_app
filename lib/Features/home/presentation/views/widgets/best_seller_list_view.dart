import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/book_list_view_item.dart';
import 'package:flutter/material.dart';

class BestSellerListView extends StatelessWidget {
  const BestSellerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), // بمعني ميبقاش فيه scroll خالص
      padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: BookListViewItem(),
      ),
      itemCount: 10,
    );
  }
}
