import 'package:http_bloc_task2/data/models/image_model.dart';
import 'package:http_bloc_task2/data/web_services/images_provider.dart';

class ImagesRepository {
  final ImageProvider imageProvider;

  ImagesRepository(this.imageProvider);

  Future<List<ImageObject>> getRandomImages() async {
    var response = await imageProvider.getRandomImages();
    return response
        .map((imageObject) => ImageObject.fromJson(imageObject.toJson()))
        .toList();
  }
}
