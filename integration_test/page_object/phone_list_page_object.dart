import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_screen.dart';

class PhoneListPageObject {
  final WidgetTester tester;

  PhoneListPageObject(this.tester);

  final page = const PhoneListScreen();

  Future<void> init() async {
    await tester.pumpAndSettle();
  }

  Future<void> _tapOnTab(String key) async {
    final tabFinder = find.byKey(ValueKey(key));
    await tester.tap(tabFinder);
    await tester.pumpAndSettle();
  }

  Future<void> tapMobileListTab() async {
    await _tapOnTab(firstTabKey);
  }

  Future<void> tapFavoriteListTab() async {
    await _tapOnTab(secondTabKey);
  }

  Future<void> toggleFavorite(int phoneId) async {
    final item = find.byKey(ValueKey(phoneId));
    final favIconFinder =
        find.descendant(of: item, matching: find.byType(IconButton));
    await tester.tap(favIconFinder);
    await tester.pumpAndSettle();
  }

  PhoneListPageObject expectPageIsVisible() {
    expect(find.byType(PhoneListScreen), findsOneWidget);
    return this;
  }

  PhoneListPageObject expectPhoneIsFavoriteInMobileTab(int phoneId) {
    final list = find.byKey(const ValueKey(mobileListKey));
    final phoneListItemFinder =
        find.descendant(of: list, matching: find.byKey(ValueKey(phoneId)));
    final favIconFinder = find.descendant(
        of: phoneListItemFinder, matching: find.byType(IconButton));

    final favIcon = tester.widget<IconButton>(favIconFinder);
    expect((favIcon.icon as Icon).icon, equals(Icons.favorite));
    return this;
  }

  PhoneListPageObject expectPhoneIsNotFavoriteInMobileTab(int phoneId) {
    final list = find.byKey(const ValueKey(mobileListKey));
    final phoneListItemFinder =
        find.descendant(of: list, matching: find.byKey(ValueKey(phoneId)));
    final favIconFinder = find.descendant(
        of: phoneListItemFinder, matching: find.byType(IconButton));

    final favIcon = tester.widget<IconButton>(favIconFinder);
    expect((favIcon.icon as Icon).icon, equals(Icons.favorite_border));
    return this;
  }

  PhoneListPageObject expectPhoneIsInFavoriteTab(int phoneId) {
    final list = find.byKey(const ValueKey(favoriteListKey));
    final phoneListItemFinder =
        find.descendant(of: list, matching: find.byKey(ValueKey(phoneId)));
    expect(phoneListItemFinder, findsOneWidget);
    return this;
  }

  PhoneListPageObject expectPhoneIsNotInFavoriteTab(int phoneId) {
    final list = find.byKey(const ValueKey(favoriteListKey));
    final phoneListItemFinder =
        find.descendant(of: list, matching: find.byKey(ValueKey(phoneId)));
    expect(phoneListItemFinder, findsNothing);
    return this;
  }
}
