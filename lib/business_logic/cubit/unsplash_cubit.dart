import 'package:bloc/bloc.dart';
import 'package:http_bloc_task2/data/images_repository.dart';
import 'package:http_bloc_task2/data/models/image_model.dart';
import 'package:meta/meta.dart';

part 'unsplash_state.dart';

class UnsplashCubit extends Cubit<UnsplashState> {
  final ImagesRepository imagesRepository;

  UnsplashCubit(this.imagesRepository) : super(UnsplashInitial());

  void getRandomImages() {
    imagesRepository.getRandomImages().then(
          (value) => emit(
            RandomImages(
              randomImages: value,
            ),
          ),
        );
  }
}
