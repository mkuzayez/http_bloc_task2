import 'package:http_bloc_task2/data/models/image/image_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response.g.dart';

@JsonSerializable()

class SearchResponse {
  final int total;
  final List<ImageObject> results;

  SearchResponse(
      {required this.total, required this.results});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<ImageObject> resultsList =
        list.map((i) => ImageObject.fromJson(i)).toList();

    return SearchResponse(
      total: json['total'],
      results: resultsList,
    );
  }
}
