import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneItemDetailsScreenArguments {
  final int phoneId;

  PhoneItemDetailsScreenArguments(this.phoneId);
}

class PhoneItemDetailsScreen extends ConsumerWidget {
  const PhoneItemDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/phone_details';

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final args = ModalRoute.of(context)!.settings.arguments
        as PhoneItemDetailsScreenArguments;
    return Center(
      child: Text('${args.phoneId}'),
    );
  }
}
