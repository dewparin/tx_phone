import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tx_phone/login/login_page.dart';

class LoginPageObject {
  final WidgetTester tester;

  LoginPageObject(this.tester);

  final page = const LoginPage();

  Finder get _textFieldFinder => find.byType(TextFormField);

  Finder get _buttonFinder => find.byType(OutlinedButton);

  Future<void> init() async {
    await tester.pumpAndSettle();
  }

  Future<void> enterIdText(String text) async {
    await tester.tap(_textFieldFinder);
    await tester.pumpAndSettle();
    await tester.enterText(_textFieldFinder, text);
    await tester.pumpAndSettle();
  }

  Future<void> tapSubmitButton() async {
    await tester.tap(_buttonFinder);
    await tester.pumpAndSettle();
  }

  LoginPageObject verifySubmitButtonIsEnabled() {
    final submitButton = tester.widget<OutlinedButton>(_buttonFinder);
    expect(submitButton.onPressed, isNotNull);
    return this;
  }

  LoginPageObject verifySubmitButtonIsDisabled() {
    final submitButton = tester.widget<OutlinedButton>(_buttonFinder);
    expect(submitButton.onPressed, null);
    return this;
  }
}
