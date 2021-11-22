import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tx_phone/main.dart' as app;

import '../page_object/login_page_object.dart';
import '../page_object/phone_list_page_object.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<PhoneListPageObject> setup(WidgetTester tester) async {
    app.main();
    final loginPage = LoginPageObject(tester);
    await loginPage.init();
    await loginPage.enterIdText('1234567');
    await loginPage.tapSubmitButton();

    return PhoneListPageObject(tester);
  }

  group('toggle favorite flow test', () {
    testWidgets('set favorite phone', (WidgetTester tester) async {
      final page = await setup(tester);

      const targetId = 1;
      await page.toggleFavorite(targetId);
      page.verifyPhoneIsFavorite(targetId);
    });

    testWidgets('remove favorite phone', (WidgetTester tester) async {
      final page = await setup(tester);

      const targetId = 1;
      await page.toggleFavorite(targetId);
      page.verifyPhoneIsFavorite(targetId);
      await page.toggleFavorite(targetId);
      page.verifyPhoneIsNotFavorite(targetId);
    });
  });
}
