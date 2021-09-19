import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tx_phone/constant.dart';
import 'package:tx_phone/entity/phone.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_model.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/widgets/phone_list_view.dart';

enum SortingOption {
  priceLowToHigh,
  priceHighToLow,
  ratingHighToLow,
}

final currentSortingOption =
    StateProvider((ref) => SortingOption.priceLowToHigh);

class PhoneListScreen extends ConsumerWidget {
  const PhoneListScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Builder(builder: (BuildContext context) {
      return watch(getPhonesFutureProvider).when(loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }, error: (_, __) {
        return _buildErrorView(context);
      }, data: (phones) {
        return _buildMainContent(context, phones);
      });
    });
  }

  Widget _buildErrorView(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(),
              const Text('Something went wrong!'),
              const Padding(padding: EdgeInsets.only(bottom: defaultPadding)),
              OutlinedButton.icon(
                onPressed: () {
                  context.refresh(getPhonesFutureProvider);
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
              const Spacer(),
            ],
          ),
        ),
      );

  Widget _buildMainContent(BuildContext context, List<Phone> phones) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('Mobile Phone'),
        ),
        body: const PhoneListView(),
      );
}
