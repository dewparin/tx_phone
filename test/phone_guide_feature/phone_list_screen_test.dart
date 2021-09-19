import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_model.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_screen.dart';

import 'mock_data.dart';

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
}
