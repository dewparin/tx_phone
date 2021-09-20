import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phone_image.freezed.dart';

part 'phone_image.g.dart';

@freezed
class PhoneImage with _$PhoneImage {
  factory PhoneImage({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'mobile_id') required int mobileId,
    @JsonKey(name: 'url') required String url,
  }) = _PhoneImage;

  factory PhoneImage.fromJson(Map<String, dynamic> json) => _$PhoneImageFromJson(json);
}
