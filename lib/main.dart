import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task2/business_logic/cubit/unsplash_cubit.dart';
import 'package:http_bloc_task2/home_screen.dart';
import 'package:http_bloc_task2/injection.dart';

void main() {
  initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => inject<UnsplashCubit>(),
        child: const HomeScreen(),
      ),
    );
  }
}
