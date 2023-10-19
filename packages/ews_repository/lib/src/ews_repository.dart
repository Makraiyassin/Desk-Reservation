import 'dart:async';

import 'package:ews_api/ews_api.dart';

class EWSRepository {
  EWSRepository({
    EWSApiClient? ewsApiClient,
  }) : _ewsApiClient = ewsApiClient ?? EWSApiClient();

  final EWSApiClient _ewsApiClient;

  Future<String?> checkReservation(String deskName) =>
      _ewsApiClient.checkReservation(deskName);
}
