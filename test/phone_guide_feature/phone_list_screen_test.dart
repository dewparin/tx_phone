import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tx_phone/data/phone_repository.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_model.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_screen.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/widgets/phone_list_item.dart';

import 'mock_data.dart';
import 'phone_list_screen_test.mocks.dart';

@GenerateMocks([PhoneRepository])
void main() {
  group('sortedPhoneListProvider', () {
    test('sortPriceLowToHigh', () {
      final mockPhones = [phoneA, phoneB, phoneC];
      const sort = SortingOption.priceLowToHigh;
      final container = ProviderContainer(
        overrides: [
          phoneListProvider.overrideWithValue(PhoneList(mockPhones.toList())),
          currentSortingOption.overrideWithProvider(StateProvider((_) => sort)),
        ],
      );

      expect(container.read(sortedPhoneListProvider), mockPhones);
    });
    test('sortPriceHighToLow', () {
      final mockPhones = [phoneC, phoneB, phoneA];
      const sort = SortingOption.priceHighToLow;
      final container = ProviderContainer(
        overrides: [
          phoneListProvider.overrideWithValue(PhoneList(mockPhones.toList())),
          currentSortingOption.overrideWithProvider(StateProvider((_) => sort)),
        ],
      );

      expect(container.read(sortedPhoneListProvider), mockPhones);
    });
    test('sortRatingHighToLow', () {
      final mockPhones = [phoneB, phoneC, phoneA];
      const sort = SortingOption.ratingHighToLow;
      final container = ProviderContainer(
        overrides: [
          phoneListProvider.overrideWithValue(PhoneList(mockPhones.toList())),
          currentSortingOption.overrideWithProvider(StateProvider((_) => sort)),
        ],
      );

      expect(container.read(sortedPhoneListProvider), mockPhones);
    });
  });

  group('widget test', () {
    final mockPhones = [
      phoneA,
      phoneB,
      phoneC,
    ];
    testWidgets('PhoneListScreen startup test', (WidgetTester tester) async {
      final mockRepository = MockPhoneRepository();
      final sut = ProviderScope(
        overrides: [
          repositoryProvider
              .overrideWithProvider(Provider((ref) => mockRepository)),
        ],
        child: const MaterialApp(
          home: PhoneListScreen(),
        ),
      );

      when(mockRepository.fetchPhones(any)).thenAnswer((_) async => mockPhones);
      await tester.pumpWidget(sut);

      // find progress indicator first
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // expect data
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsNothing);

      expect(tester.widgetList(find.byType(PhoneListItem)), [
        isA<PhoneListItem>()
            .having((it) => it.phone.id, 'Phone ID', mockPhones.first.id),
        isA<PhoneListItem>()
            .having((it) => it.phone.id, 'Phone ID', mockPhones[1].id),
        isA<PhoneListItem>()
            .having((it) => it.phone.id, 'Phone ID', mockPhones[2].id),
      ]);
    });
  });
}
