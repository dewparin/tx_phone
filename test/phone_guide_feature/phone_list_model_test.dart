// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tx_phone/data/phone_repository.dart';
import 'package:tx_phone/entity/phone.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_model.dart';

import 'mock_data.dart';
import 'phone_list_model_test.mocks.dart';

@GenerateMocks([PhoneRepository, PhoneList])
void main() {
  final mockPhones = [
    phoneA,
    phoneB,
    phoneC,
  ];
  group('getPhonesFutureProvider', () {
    test('whenRepositoryCompletesSuccessfully_shouldReturnCorrectPhoneList',
        () async {
      final mockRepository = MockPhoneRepository();
      final mockPhoneListStateNotifier = MockPhoneList();
      final container = ProviderContainer(
        overrides: [
          repositoryProvider
              .overrideWithProvider(Provider((ref) => mockRepository)),
          phoneListProvider.overrideWithProvider(
              StateNotifierProvider((ref) => mockPhoneListStateNotifier)),
        ],
      );

      when(mockRepository.fetchPhones(any)).thenAnswer((_) async => mockPhones);

      expect(container.read(getPhonesFutureProvider),
          const AsyncValue<List<Phone>>.loading());
      await Future<void>.value();
      final result = container.read(getPhonesFutureProvider).data!.value;
      expect(result, mockPhones);
      verify(mockPhoneListStateNotifier.setNewPhoneList(mockPhones));
    });

    test('whenRepositoryError_shouldReturnError', () async {
      final mockRepository = MockPhoneRepository();
      final mockPhoneListStateNotifier = MockPhoneList();
      final container = ProviderContainer(
        overrides: [
          repositoryProvider
              .overrideWithProvider(Provider((ref) => mockRepository)),
          phoneListProvider.overrideWithProvider(
              StateNotifierProvider((ref) => mockPhoneListStateNotifier)),
        ],
      );

      when(mockRepository.fetchPhones(any)).thenThrow(Exception('Error'));

      expect(container.read(getPhonesFutureProvider),
          const AsyncValue<List<Phone>>.loading());
      await Future<void>.value();
      expect(container.read(getPhonesFutureProvider),
          const AsyncValue<Never>.loading());
      verifyNever(mockPhoneListStateNotifier.setNewPhoneList(any));
    });
  });
}
