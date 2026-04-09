import 'package:dio/dio.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../models/nominatim_place_model.dart';

abstract class NominatimRemoteDatasource {
  Future<List<NominatimPlaceModel>> searchPlaces(String query);
}

class NominatimRemoteDatasourceImpl implements NominatimRemoteDatasource {
  final Dio _dio;

  NominatimRemoteDatasourceImpl(this._dio);

  @override
  Future<List<NominatimPlaceModel>> searchPlaces(String query) async {
    final response = await _dio.get(
      '${AppStrings.nominatimBaseUrl}/search',
      queryParameters: {
        'q': query,
        'countrycodes': AppConstants.nominatimCountryCode,
        'format': 'json',
        'limit': AppConstants.searchResultLimit,
        'addressdetails': 1,
      },
      options: Options(
        headers: {
          'User-Agent': AppStrings.userAgent,
          'Accept-Language': AppStrings.searchLanguage,
        },
      ),
    );

    final payload = response.data as List<dynamic>? ?? const [];
    return payload
        .whereType<Map<String, dynamic>>()
        .map(NominatimPlaceModel.fromJson)
        .toList(growable: false);
  }
}
