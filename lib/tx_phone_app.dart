import 'package:flutter/material.dart';
import 'package:tx_phone/login/login_page.dart';
import 'package:tx_phone/phone_guide_feature/phone_item_details/phone_item_details_screen.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_screen.dart';

class TxPhoneApp extends StatelessWidget {
  const TxPhoneApp({Key? key}) : super(key: key);

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
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (_) => const LoginPage(),
        PhoneListScreen.routeName: (_) => const PhoneListScreen(),
        PhoneItemDetailsScreen.routeName: (_) => const PhoneItemDetailsScreen(),
      },
    );
  }
}
