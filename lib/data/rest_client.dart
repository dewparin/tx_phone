import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tx_phone/entity/phone.dart';

part 'rest_client.g.dart';

const _baseUrl = 'https://scb-test-mobile.herokuapp.com/api';
final _dioProvider = Provider((ref) => Dio(BaseOptions(baseUrl: _baseUrl)));

final restClientProvider =
    Provider((ref) => RestClient(ref.read(_dioProvider)));

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/mobiles")
  Future<List<Phone>> getPhones(
    @CancelRequest() CancelToken cancelToken,
  );
}
