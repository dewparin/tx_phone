import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tx_phone/constant.dart';
import 'package:tx_phone/entity/phone.dart';
import 'package:tx_phone/phone_guide_feature/phone_item_details/phone_item_details_model.dart';

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
    final phone = watch(phoneDetailsProvider(args.phoneId));
    return Scaffold(
      appBar: AppBar(
        title: Text(phone.name),
      ),
      body: Column(children: [
        Expanded(
          child: _buildCoverSection(context, phone, watch),
        ),
        Expanded(
          flex: 2,
          child: _buildContentSection(phone, context),
        ),
      ]),
    );
  }

  Stack _buildCoverSection(
          BuildContext context, Phone phone, ScopedReader watch) =>
      Stack(
        children: [
          const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              color: Colors.black45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildOverlayText(context, 'Rating: ${phone.rating}'),
                  _buildOverlayText(context, 'Price: \$${phone.price}'),
                ],
              ),
            ),
          ),
        ],
      );

  Text _buildOverlayText(BuildContext context, String text) => Text(
        text,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
            ),
      );

  Container _buildContentSection(Phone phone, BuildContext context) =>
      Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              phone.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: largePadding),
            ),
            Text(
              phone.description,
              textAlign: TextAlign.justify,
              textScaleFactor: 1.1,
            ),
          ],
        ),
      );
}
