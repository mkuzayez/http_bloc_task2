part of 'unsplash_cubit.dart';

@immutable
sealed class UnsplashState {}

final class UnsplashInitial extends UnsplashState {}

final class RandomImages extends UnsplashState {
  final List<ImageObject> randomImages;

  RandomImages({required this.randomImages});
}
