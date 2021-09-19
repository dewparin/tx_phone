import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phone.freezed.dart';

part 'phone.g.dart';

@freezed
class Phone with _$Phone {
  factory Phone({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'price') required double price,
    @JsonKey(name: 'rating') required double rating,
    @JsonKey(name: 'thumbImageURL') required String thumbImageUrl,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'brand') required String brand,
    @JsonKey(defaultValue: false) required bool isFavorite,
  }) = _Phone;

  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);
}
