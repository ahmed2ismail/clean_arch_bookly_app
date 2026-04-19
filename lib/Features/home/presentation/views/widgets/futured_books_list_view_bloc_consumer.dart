import 'package:clean_arch_bookly_app/Core/utils/functions/build_error_snack_bar.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/featured_books_list_view.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_states.dart';

class FuturedBooksListViewBlocConsumer extends StatefulWidget {
  const FuturedBooksListViewBlocConsumer({super.key});

  @override
  State<FuturedBooksListViewBlocConsumer> createState() =>
      _FuturedBooksListViewBlocConsumerState();
}

class _FuturedBooksListViewBlocConsumerState
    extends State<FuturedBooksListViewBlocConsumer> {
  List<BookEntity> books = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeaturedBooksCubit, FeaturedBooksState>(
      listener: (context, state) {
        if (state is FeaturedBooksSuccess) {
          books = state.books;
        }
        if (state is FeaturedBooksPaginationFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(buildErrorSnackBar(state.errMessage));
        }
      },

      builder: (context, state) {
        if (state is FeaturedBooksSuccess ||
            state is FeaturedBooksPaginationLoading ||
            state is FeaturedBooksPaginationFailure)
        // we want to show the list view even if there is an error in pagination, so we check for pagination failure as well
        {
          return FuturedBooksListView(books: books);
        } else if (state is FeaturedBooksFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
