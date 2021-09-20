import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tx_phone/entity/phone.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_model.dart';

final phoneDetailsProvider = Provider.family<Phone, int>((ref, phoneId) {
  final allPhones = ref.watch(phoneListProvider);
  return allPhones.firstWhere((phone) => phone.id == phoneId);
});
