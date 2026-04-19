import 'package:clean_arch_bookly_app/Core/utils/functions/build_error_snack_bar.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/newest_books_list_view.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/newest_books_list_view_fading_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewestBooksListViewBlocConsumer extends StatefulWidget {
  const NewestBooksListViewBlocConsumer({super.key});

  @override
  State<NewestBooksListViewBlocConsumer> createState() =>
      _NewestBooksListViewBlocConsumerState();
}

class _NewestBooksListViewBlocConsumerState
    extends State<NewestBooksListViewBlocConsumer> {
  List<BookEntity> books = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewestBooksCubit, NewestBooksState>(
      listener: (context, state) {
        if (state is NewestBooksSuccess) {
          books.addAll(state.books);
        }
        if (state is NewestBooksPaginationFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(buildErrorSnackBar(state.errMessage));
        }
      },

      builder: (context, state) {
        if (state is NewestBooksSuccess ||
            state is NewestBooksPaginationLoading ||
            state is NewestBooksPaginationFailure)
        // we want to show the list view even if there is an error in pagination, so we check for pagination failure as well
        {
          return NewestBooksListView(books: books);
        } else if (state is NewestBooksFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return const NewestBooksListViewFadingLoadingIndicator();
        }
      },
    );
  }
}
