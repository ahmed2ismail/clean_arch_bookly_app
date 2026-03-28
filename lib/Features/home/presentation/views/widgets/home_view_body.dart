import 'package:clean_arch_bookly_app/Core/utils/styles.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/best_seller_list_view.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/featured_books_list_view.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      // CustomScrollView widget بنستخدمها عشان نعمل nested ListView بداخلها
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(),
              FuturedBooksListView(),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text('Best Seller', style: Styles.textStyle18),
              ),
            ],
          ),
        ),
        SliverFillRemaining(child: BestSellerListView()),
        // SliverFillRemaining : بتستخدم عشان تخلي ال ListView اللي جواها تاخد المساحة المتبقية من ال screen وتتعامل معاها كأنها جزء واحد من ال scroll، وبكده حلينا مشكلة ال scrolling جوا ال ListView اللي كانت بتعارض ال CustomScrollView.
      ],
    );
  }
}
