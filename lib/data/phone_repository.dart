import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tx_phone/data/rest_client.dart';
import 'package:tx_phone/entity/phone.dart';
import 'package:tx_phone/entity/phone_image.dart';

final repositoryProvider =
    Provider((ref) => PhoneRepository(ref.read(restClientProvider)));

class PhoneRepository {
  final RestClient _restClient;

  PhoneRepository(this._restClient);

  Future<List<Phone>> fetchPhones(CancelToken cancelToken) =>
      _restClient.getPhones(cancelToken);

  Future<List<PhoneImage>> fetchPhoneImages(
          int phoneId, CancelToken cancelToken) =>
      _restClient.getPhoneImages(phoneId, cancelToken);
}
