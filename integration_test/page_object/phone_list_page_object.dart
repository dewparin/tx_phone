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

  Future<void> toggleFavorite(int phoneId) async {
    final item = find.byKey(ValueKey(phoneId));
    final favIconFinder = find.descendant(of: item, matching: find.byType(IconButton));
    await tester.tap(favIconFinder);
    await tester.pumpAndSettle();
  }

  PhoneListPageObject verifyPageIsVisible() {
    expect(find.byType(PhoneListScreen), findsOneWidget);
    return this;
  }

  PhoneListPageObject verifyPhoneIsFavorite(int phoneId) {
    final item = find.byKey(ValueKey(phoneId));
    final favIconFinder = find.descendant(of: item, matching: find.byType(IconButton));

    final favIcon = tester.widget<IconButton>(favIconFinder);
    expect((favIcon.icon as Icon).icon, equals(Icons.favorite));
    return this;
  }

  PhoneListPageObject verifyPhoneIsNotFavorite(int phoneId) {
    final phoneListItemFinder = find.byKey(ValueKey(phoneId));
    final favIconFinder = find.descendant(of: phoneListItemFinder, matching: find.byType(IconButton));

    final favIcon = tester.widget<IconButton>(favIconFinder);
    expect((favIcon.icon as Icon).icon, equals(Icons.favorite_border));
    return this;
  }
}
