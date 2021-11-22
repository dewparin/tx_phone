import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tx_phone/login/login_page.dart';

class LoginPageObject {
  final WidgetTester tester;

  LoginPageObject(this.tester);

  final page = const LoginPage();

  Finder get _textField => find.byType(TextFormField);

  Finder get _button => find.byType(OutlinedButton);

  Future<void> init() async {
    await tester.pumpAndSettle();
  }

  Future<void> enterIdText(String text) async {
    await tester.tap(_textField);
    await tester.pumpAndSettle();
    await tester.enterText(_textField, text);
    await tester.pumpAndSettle();
  }

  Future<void> tapSubmitButton() async {
    await tester.tap(_button);
    await tester.pumpAndSettle();
  }

  LoginPageObject verifySubmitButtonIsEnabled() {
    final submitButton = tester.widget<OutlinedButton>(_button);
    expect(submitButton.onPressed, isNotNull);
    return this;
  }

  LoginPageObject verifySubmitButtonIsDisabled() {
    final submitButton = tester.widget<OutlinedButton>(_button);
    expect(submitButton.onPressed, null);
    return this;
  }
}
