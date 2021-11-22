import 'package:flutter_test/flutter_test.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_screen.dart';

class PhoneListPageObject {
  final WidgetTester tester;

  PhoneListPageObject(this.tester);

  final page = const PhoneListScreen();

  Future<void> init() async {
    await tester.pumpAndSettle();
  }

  PhoneListPageObject verifyPageIsVisible() {
    expect(find.byType(PhoneListScreen), findsOneWidget);
    return this;
  }
}
