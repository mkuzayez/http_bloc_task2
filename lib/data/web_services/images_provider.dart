import 'package:dio/dio.dart';
import 'package:http_bloc_task2/data/models/image_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';

part 'images_provider.g.dart';

@RestApi(baseUrl: "https://api.unsplash.com/")
abstract class ImageProvider {
  factory ImageProvider(Dio dio, {String baseUrl}) = _ImageProvider;

  @GET('photos/random?count=10')
  Future<List<ImageObject>> getRandomImages();
}
