import 'package:flutter/material.dart';

class TxPhoneApp extends StatelessWidget {
  const TxPhoneApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TX Mobile Phone Buyer’s Guide',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.black,
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: Colors.black,
        ),
        indicatorColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
      home: const Scaffold(
        body: Center(child: Text('Hello')),
      ),
    );
  }
}
