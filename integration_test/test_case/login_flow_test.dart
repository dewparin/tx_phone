import 'package:tx_phone/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../page_object/login_page_object.dart';
import '../page_object/phone_list_page_object.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final LoginPageObject page;

  Future<LoginPageObject> setup(WidgetTester tester) async {
    app.main();
    final page = LoginPageObject(tester);
    await page.init();
    return page;
  }

  group('login flow test', () {
    testWidgets('test initial state', (WidgetTester tester) async {
      final page = await setup(tester);
      //verify initial state
      page.verifySubmitButtonIsDisabled();
    });

    testWidgets('enter valid input, expect success',
        (WidgetTester tester) async {
      final page = await setup(tester);

      //test enable button
      await page.enterIdText('1234567');
      page.verifySubmitButtonIsEnabled();

      //test tap button
      await page.tapSubmitButton();
      final phoneListPage = PhoneListPageObject(tester);
      phoneListPage.verifyPageIsVisible();
    });

    testWidgets('enter invalid input, expect error',
            (WidgetTester tester) async {
          final page = await setup(tester);

          //test disable button
          await page.enterIdText('123456');
          page.verifySubmitButtonIsDisabled();
        });
  });
}
