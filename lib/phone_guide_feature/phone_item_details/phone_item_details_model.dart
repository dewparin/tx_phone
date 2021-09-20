import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tx_phone/data/phone_repository.dart';
import 'package:tx_phone/entity/phone.dart';
import 'package:tx_phone/entity/phone_image.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_model.dart';

final phoneDetailsProvider = Provider.family<Phone, int>((ref, phoneId) {
  final allPhones = ref.watch(phoneListProvider);
  return allPhones.firstWhere((phone) => phone.id == phoneId);
});

final getPhoneImagesFutureProvider = FutureProvider.autoDispose
    .family<List<PhoneImage>, int>((ref, phoneId) async {
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);
  final repository = ref.watch(repositoryProvider);
  final images = await repository.fetchPhoneImages(phoneId, cancelToken);
  ref.maintainState = true;
  return images;
});
