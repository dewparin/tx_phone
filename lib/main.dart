import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tx_phone/tx_phone_app.dart';

void main() {
  runApp(const ProviderScope(
    child: TxPhoneApp(),
  ));
}
