import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tx_phone/constant.dart';
import 'package:tx_phone/entity/phone.dart';

class PhoneListItem extends ConsumerWidget {
  final Phone phone;

  const PhoneListItem({
    Key? key,
    required this.phone,
  }) : super(key: key);

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
            buildHeaderSection(context, phone),
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

  Widget buildHeaderSection(BuildContext context, Phone phone) => Text(
        phone.name,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline6,
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
