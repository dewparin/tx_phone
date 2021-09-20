import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tx_phone/constant.dart';
import 'package:tx_phone/entity/phone.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_model.dart';

enum PhoneListItemLayout {
  regular,
  noFavorite,
}

class PhoneListItem extends ConsumerWidget {
  final Phone phone;
  final PhoneListItemLayout layout;

  const PhoneListItem({
    Key? key,
    required this.phone,
    this.layout = PhoneListItemLayout.regular,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    if (layout == PhoneListItemLayout.noFavorite) {
      return _NoFavoritePhoneListItem(phone);
    } else {
      return _RegularPhoneListItem(phone);
    }
  }
}

abstract class _BasePhoneListItem extends ConsumerWidget {
  final Phone phone;

  const _BasePhoneListItem({
    Key? key,
    required this.phone,
  }) : super(key: key);

  Widget buildHeaderSection(
      BuildContext context, ScopedReader watch, Phone phone);

  void _navigateToPhoneDetailsScreen(BuildContext context) {
    // TODO : navigate to phone details screen later.
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) => Card(
        child: InkWell(
          onTap: () {
            _navigateToPhoneDetailsScreen(context);
          },
          child: SizedBox(
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Image.network(
                      phone.thumbImageUrl,
                      errorBuilder: (_, __, ___) {
                        return const Icon(Icons.warning);
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: smallPadding),
                ),
                Expanded(
                  flex: 3,
                  child: _buildDescriptionSection(context, watch),
                )
              ],
            ),
          ),
        ),
      );

  Container _buildDescriptionSection(
          BuildContext context, ScopedReader watch) =>
      Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildHeaderSection(context, watch, phone),
            Text(
              phone.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
            Expanded(child: _buildBottomRow(context)),
          ],
        ),
      );

  Row _buildBottomRow(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Price: \$${phone.price}',
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            'Rating: ${phone.rating}',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      );
}

class _RegularPhoneListItem extends _BasePhoneListItem {
  const _RegularPhoneListItem(Phone phone) : super(phone: phone);

  @override
  Widget buildHeaderSection(
          BuildContext context, ScopedReader watch, Phone phone) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            phone.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline6,
          ),
          IconButton(
              icon: phone.isFavorite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              color: phone.isFavorite ? Colors.red[500] : null,
              onPressed: () {
                watch(phoneListProvider.notifier).toggleFavorite(phone.id);
              }),
        ],
      );
}

class _NoFavoritePhoneListItem extends _BasePhoneListItem {
  const _NoFavoritePhoneListItem(Phone phone) : super(phone: phone);

  @override
  Widget buildHeaderSection(
          BuildContext context, ScopedReader watch, Phone phone) =>
      Column(
        children: [
          Text(
            phone.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline6,
          ),
          const Padding(padding: EdgeInsets.only(bottom: defaultPadding)),
        ],
      );
}
