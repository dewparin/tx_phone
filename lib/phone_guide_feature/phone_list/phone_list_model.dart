import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tx_phone/entity/phone.dart';

final phoneListProvider = StateNotifierProvider<PhoneList, List<Phone>>((ref) {
  return PhoneList([]);
});

class PhoneList extends StateNotifier<List<Phone>> {
  PhoneList(List<Phone> state) : super(state);

  void setNewPhoneList(List<Phone> phones) {
    state = phones;
  }
}
