import 'dart:convert';

import 'package:http/http.dart' as http;

/// Exception thrown when getCheckReservations fails.
class CheckReservationFailure implements Exception {}

/// Exception thrown when the provided checkReservations are not found.
class CheckReservationNotFoundFailure implements Exception {}

/// {@template checkReservation_api_client}
/// Dart API Client that provides access to a list of checkReservations from the [Drupal API].
/// {@endtemplate}
class EWSApiClient {
  EWSApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  final _baseUrlEWS = 'etnicdeskreservation.westeurope.azurecontainer.io';

  Future<String?> checkReservation(String deskName) async {
    final checkReservationRequest = Uri.http(
      _baseUrlEWS,
      'check_reservation',
      {
        'desk_name': deskName,
      },
    );

    final checkReservationResponse =
        await _httpClient.get(checkReservationRequest);

    if (checkReservationResponse.statusCode != 200) {
      throw CheckReservationFailure();
    }

    final checkReservationJson =
        jsonDecode(checkReservationResponse.body) as Map;

    if (!checkReservationJson.containsKey('reservedBy'))
      throw CheckReservationNotFoundFailure();

    final result = checkReservationJson['reservedBy'] as String?;

    return result;
  }
}
