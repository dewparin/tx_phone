import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tx_phone/constant.dart';
import 'package:tx_phone/entity/phone.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_model.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/widgets/phone_list_item.dart';

class PhoneListView extends ConsumerWidget {
  const PhoneListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) => Builder(
        builder: (BuildContext context) {
          final phones = watch(phoneListProvider);
          if (phones.isNotEmpty) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: smallPadding),
              child: ListView.separated(
                itemCount: phones.length,
                itemBuilder: (context, index) {
                  return _buildPhoneListItem(phones[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: smallPadding);
                },
              ),
            );
          } else {
            return const Center(child: Text('No Phones Here :-('));
          }
        },
      );

  Widget _buildPhoneListItem(Phone phone) => PhoneListItem(phone: phone);
}
