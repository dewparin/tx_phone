import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tx_phone/data/phone_repository.dart';
import 'package:tx_phone/entity/phone.dart';

final getPhonesFutureProvider = FutureProvider.autoDispose((ref) async {
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);
  final repository = ref.watch(repositoryProvider);
  final phones = await repository.fetchPhones(cancelToken);
  ref.maintainState = true;
  ref.read(phoneListProvider.notifier).setNewPhoneList(phones);
  return phones;
});

final phoneListProvider = StateNotifierProvider<PhoneList, List<Phone>>((ref) {
  return PhoneList([]);
});

class PhoneList extends StateNotifier<List<Phone>> {
  PhoneList(List<Phone> state) : super(state);

  void setNewPhoneList(List<Phone> phones) {
    state = phones;
  }
}
