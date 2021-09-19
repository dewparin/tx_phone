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

final sortedPhoneListProvider = Provider<List<Phone>>((ref) {
  final sortingOption = ref.watch(currentSortingOption);
  final allPhones = ref.watch(phoneListProvider);
  switch (sortingOption.state) {
    case SortingOption.priceLowToHigh:
      allPhones.sort((a, b) => a.price.compareTo(b.price));
      break;
    case SortingOption.priceHighToLow:
      allPhones.sort((a, b) => b.price.compareTo(a.price));
      break;
    case SortingOption.ratingHighToLow:
      allPhones.sort((a, b) => b.rating.compareTo(a.rating));
      break;
  }
  return allPhones.toList();
});

final sortedFavoritePhoneList = AutoDisposeProvider<List<Phone>>((ref) {
  final allPhones = ref.watch(sortedPhoneListProvider);
  return allPhones.where((phone) => phone.isFavorite).toList();
});

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
      DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Mobile Phone'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Mobile List'.toUpperCase()),
                Tab(text: 'Favorite List'.toUpperCase()),
              ],
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: _SortingOptionsDialog(),
                            );
                          });
                    },
                    child: const Icon(
                      Icons.sort,
                      size: 26.0,
                    ),
                  )),
            ],
          ),
          body: const TabBarView(
            children: [
              PhoneListView(),
              PhoneListView(
                layout: PhoneListViewLayout.favorite,
              ),
            ],
          ),
        ),
      );
}

class _SortingOptionsDialog extends ConsumerWidget {
  const _SortingOptionsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildRadioListTile(
          scopeReader: watch,
          label: 'Price low to high',
          option: SortingOption.priceLowToHigh,
        ),
        _buildRadioListTile(
          scopeReader: watch,
          label: 'Price high to low',
          option: SortingOption.priceHighToLow,
        ),
        _buildRadioListTile(
          scopeReader: watch,
          label: 'Rating 5 - 1',
          option: SortingOption.ratingHighToLow,
        ),
      ],
    );
  }

  RadioListTile _buildRadioListTile({
    required ScopedReader scopeReader,
    required String label,
    required SortingOption option,
  }) =>
      RadioListTile<SortingOption>(
        contentPadding: const EdgeInsets.all(0.0),
        title: Text(label),
        value: option,
        groupValue: scopeReader(currentSortingOption).state,
        onChanged: (_) {
          scopeReader(currentSortingOption).state = option;
        },
      );
}
