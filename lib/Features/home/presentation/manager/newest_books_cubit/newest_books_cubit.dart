import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/usecases/fetch_newest_books_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit({required this.fetchBestNewestBooksUseCase})
    : super(NewestBooksInitial());
  final FetchBestNewestBooksUseCase fetchBestNewestBooksUseCase;

  Future<void> fetchNewestBooks({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(NewestBooksLoading());
    } else {
      emit(NewestBooksPaginationLoading());
    }
    final result = await fetchBestNewestBooksUseCase.call(pageNumber);
    result.fold(
      (failure) => pageNumber == 0
          ? emit(NewestBooksFailure(failure.errMessage))
          : emit(NewestBooksPaginationFailure(failure.errMessage)),
      (books) => emit(NewestBooksSuccess(books)),
    );
  }
}
