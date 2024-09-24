import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ImageObject {
  final String? slug;
  @JsonKey(name: "blur_hash")
  final String? blurHash;
  @JsonKey(name: "alt_description")
  final String? photoDescription;
  final int height;
  final int width;
  final Urls? urls;
  final Links? links;
  final User? user;

  ImageObject({
    required this.slug,
    required this.blurHash,
    required this.photoDescription,
    required this.height,
    required this.width,
    required this.urls,
    required this.links,
    required this.user,
  });

  factory ImageObject.fromJson(Map<String, dynamic> json) =>
      _$ImageObjectFromJson(json);

  Map<String, dynamic> toJson() => _$ImageObjectToJson(this);
}

@JsonSerializable()
class Urls {
  final String? raw;
  final String? full;
  final String? regular;

  const Urls({
    this.raw,
    this.full,
    this.regular,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsToJson(this);
}

@JsonSerializable()
class Links {
  @JsonKey(name: "download_location")
  final String? downloadLink;

  const Links({
    this.downloadLink,
  });

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class User {
  final String? name;
  @JsonKey(name: "instagram_username")
  final String? instagramUsername;

  const User({
    required this.name,
    required this.instagramUsername,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
