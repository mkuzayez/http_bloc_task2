import 'package:dio/dio.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';
import 'package:http_bloc_task2/data/models/topic/topic_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';

part 'data_provider.g.dart';

@RestApi(baseUrl: "https://api.unsplash.com/")
abstract class DataProvider {
  factory DataProvider(Dio dio, {String baseUrl}) = _DataProvider;

  @GET('photos/random?count=10')
  Future<List<ImageObject>> getRandomImages();

  @GET('topics')
  Future<List<TopicObject>> getTopics();

  @GET('topics/{topic}/photos')
  Future<List<ImageObject>> getTopicImages(@Path() String topic);

  @GET('search/photos')
  Future<List<ImageObject>> searchImages(@Query('query') String query);
}
