import '../../domain/entities/place_entity.dart';
import '../../domain/repositories/places_repository.dart';
import '../datasources/nominatim_remote_datasource.dart';

class NominatimRepositoryImpl implements PlacesRepository {
  final NominatimRemoteDatasource _remoteDatasource;

  NominatimRepositoryImpl(this._remoteDatasource);

  @override
  Future<List<PlaceEntity>> searchPlaces(String query) {
    return _remoteDatasource.searchPlaces(query);
  }
}
