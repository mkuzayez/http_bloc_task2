// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageObject _$ImageObjectFromJson(Map<String, dynamic> json) => ImageObject(
      slug: json['slug'] as String? ?? 'unavailable',
      blurHash: json['blur_hash'] as String? ?? 'unavailable',
      photoDescription: json['alt_description'] as String? ?? 'unavailable',
      height: json['height'] as int,
      width: json['width'] as int,
      urls: json['urls'] == null
          ? null
          : Urls.fromJson(json['urls'] as Map<String, dynamic>),
      links: json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ImageObjectToJson(ImageObject instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'blur_hash': instance.blurHash,
      'alt_description': instance.photoDescription,
      'height': instance.height,
      'width': instance.width,
      'urls': instance.urls?.toJson(),
      'links': instance.links?.toJson(),
      'user': instance.user?.toJson(),
    };

Urls _$UrlsFromJson(Map<String, dynamic> json) => Urls(
      raw: json['raw'] as String?,
      full: json['full'] as String?,
      regular: json['regular'] as String?,
    );

Map<String, dynamic> _$UrlsToJson(Urls instance) => <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      downloadLink: json['download_location'] as String?,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'download_location': instance.downloadLink,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String? ?? 'unavailable',
      instagramUsername: json['instagram_username'] as String? ?? 'unavailable',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'instagram_username': instance.instagramUsername,
    };
