import 'package:clean_arch_bookly_app/Core/utils/api_service.dart';
import 'package:clean_arch_bookly_app/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:clean_arch_bookly_app/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:clean_arch_bookly_app/Features/home/data/repositories/home_repo_impl.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/repositories/home_repo.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/usecases/fetch_featured_books_use_case.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/usecases/fetch_newest_books_use_case.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  // here we will register all our dependencies like cubits, use cases, repositories, data sources, etc.

  // Cubits
  sl.registerFactory(() => FeaturedBooksCubit(sl<FetchFeaturedBooksUseCase>()));
  sl.registerFactory(
    () => NewestBooksCubit(
      fetchBestNewestBooksUseCase: sl<FetchBestNewestBooksUseCase>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => FetchFeaturedBooksUseCase(sl<HomeRepo>()));
  sl.registerLazySingleton(() => FetchBestNewestBooksUseCase(sl<HomeRepo>()));

  // Repositories
  sl.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(
      homeRemoteDataSource: sl<HomeRemoteDataSource>(),
      homeLocalDataSource: sl<HomeLocalDataSource>(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl<ApiService>()),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );

  // Network
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));

  // External Packages
  // Dio
  // هنا انا سجلت ال Dio في ال injection container عشان اقدر استخدمه في اي مكان في التطبيق من غير ما اعمل instance جديد منه كل مرة
  sl.registerLazySingleton<Dio>(() => Dio());
}
