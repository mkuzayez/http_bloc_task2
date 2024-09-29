import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task2/business_logic/bloc/unsplash_bloc.dart';
import 'package:http_bloc_task2/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:http_bloc_task2/data/hive_storage.dart';
import 'package:http_bloc_task2/data/images_repository.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';
import 'package:http_bloc_task2/data/models/topic/topic_model.dart';
import 'package:http_bloc_task2/data/web_services/data_provider.dart';
import 'package:http_bloc_task2/view/screens/details_screen.dart';
import 'package:http_bloc_task2/view/screens/favorite_screen.dart';
import 'package:http_bloc_task2/view/screens/home_screen.dart';
import 'package:http_bloc_task2/view/screens/search_screen.dart';
import 'package:http_bloc_task2/view/screens/topic_screen.dart';

class AppRouter {
  Dio setupDio() {
    Dio dio = Dio();

    dio
      ..options.connectTimeout = const Duration(seconds: 20)
      ..options.receiveTimeout = const Duration(seconds: 20);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.queryParameters['client_id'] =
            'qW08jDN2H6IQkobNr6HgvLIn0FZnfqZK2XuchL8vDAQ';
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

  late ImagesRepository imagesRepository;
  late FavoritesCubit favoritesCubit;
  late UnsplashBloc unsplashBloc;
  late DataProvider dataProvider;
  late HiveStorage hiveStorage;

  AppRouter() {
    hiveStorage = HiveStorage();
    dataProvider = DataProvider(setupDio());
    imagesRepository = ImagesRepository(dataProvider);
    unsplashBloc = UnsplashBloc(imagesRepository);
    favoritesCubit = FavoritesCubit(hiveStorage);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: unsplashBloc,
              ),
              BlocProvider.value(
                value: favoritesCubit,
              ),
            ],
            child: const HomeScreen(),
          ),
        );

      case '/details':
        final imageObject = settings.arguments as ImageObject;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: favoritesCubit,
            child: DetailsScreen(
              image: imageObject,
            ),
          ),
        );

      case '/favorite':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: favoritesCubit,
            child: const FavoritesScreen(),
          ),
        );

      case '/topic':
        final tobicObject = settings.arguments as TopicObject;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: unsplashBloc,
              ),
              BlocProvider.value(
                value: favoritesCubit,
              ),
            ],
            child: TopicScreen(topic: tobicObject),
          ),
        );

      case '/search':
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: unsplashBloc,
              ),
              BlocProvider.value(
                value: favoritesCubit,
              ),
            ],
            child: const SearchScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No Route Found'),
            ),
          ),
        );
    }
  }
}
