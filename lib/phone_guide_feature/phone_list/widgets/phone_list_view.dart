import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tx_phone/constant.dart';
import 'package:tx_phone/entity/phone.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_screen.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/widgets/phone_list_item.dart';

enum PhoneListViewLayout {
  regular,
  favorite,
}

class PhoneListView extends StatelessWidget {
  final PhoneListViewLayout layout;

  const PhoneListView({
    Key? key,
    this.layout = PhoneListViewLayout.regular,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (layout == PhoneListViewLayout.favorite) {
      return const _FavoritePhoneListView();
    } else {
      return const _RegularPhoneListView();
    }
  }
}

abstract class _BasePhoneListView extends ConsumerWidget {
  const _BasePhoneListView({
    Key? key,
    required this.listKeyValue,
    this.layout = PhoneListViewLayout.regular,
  }) : super(key: key);

  final String listKeyValue;
  final PhoneListViewLayout layout;

  RootProvider getSourceProvider();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Builder(
      builder: (BuildContext context) {
        final phones = watch(getSourceProvider());
        if (phones.isNotEmpty) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: smallPadding),
            child: ListView.separated(
              key: PageStorageKey(listKeyValue),
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
  }

  Widget _buildPhoneListItem(Phone phone) => PhoneListItem(phone: phone);
}

class _RegularPhoneListView extends _BasePhoneListView {
  const _RegularPhoneListView() : super(listKeyValue: '_RegularPhoneListView');

  @override
  RootProvider getSourceProvider() => sortedPhoneListProvider;
}

class _FavoritePhoneListView extends _BasePhoneListView {
  const _FavoritePhoneListView()
      : super(listKeyValue: '_FavoritePhoneListView');

  @override
  RootProvider getSourceProvider() => sortedFavoritePhoneList;
}
