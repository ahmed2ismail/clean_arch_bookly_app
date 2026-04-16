import 'package:clean_arch_bookly_app/Features/home/domain/usecases/fetch_featured_books_use_case.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  final FetchFeaturedBooksUseCase fetchFeaturedBooksUseCase;

  FeaturedBooksCubit(this.fetchFeaturedBooksUseCase) : super(FeaturedBooksInitial());

  Future<void> fetchFeaturedBooks() async {
    emit(FeaturedBooksLoading());
    final result = await fetchFeaturedBooksUseCase.call();
    result.fold(
      (failure) => emit(FeaturedBooksFailure(failure.errMessage)),
      (books) => emit(FeaturedBooksSuccess(books)),
    );
  }
}