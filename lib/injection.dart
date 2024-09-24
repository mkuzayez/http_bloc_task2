import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http_bloc_task2/business_logic/cubit/unsplash_cubit.dart';
import 'package:http_bloc_task2/data/images_repository.dart';
import 'package:http_bloc_task2/data/web_services/images_provider.dart';

final inject = GetIt.instance;

void initGetIt() {
  inject.registerLazySingleton<UnsplashCubit>(() => UnsplashCubit(inject()));
  inject.registerLazySingleton<ImagesRepository>(
      () => ImagesRepository(inject()));
  inject.registerLazySingleton<ImageProvider>(() => ImageProvider(setupDio()));
}

Dio setupDio() {
  Dio dio = Dio();

  dio
    ..options.connectTimeout = const Duration(seconds: 20)
    ..options.receiveTimeout = const Duration(seconds: 20);

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.queryParameters['client_id'] =
          'HPRI7Pz2AaDU4owYy4Ia5iIqHyZjiWxUqzD6gW3gUqQ';
      return handler.next(options);
    },
    onError: (DioException e, handler) {
      return handler.next(e);
    },
  ));

  dio.interceptors.add(
    LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: false,
      responseHeader: false,
      request: true,
      requestBody: true,
    ),
  );

  return dio;
}
