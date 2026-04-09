import '../entities/place_entity.dart';
import '../repositories/places_repository.dart';

class SearchPlacesUsecase {
  final PlacesRepository _placesRepository;

  SearchPlacesUsecase(this._placesRepository);

  Future<List<PlaceEntity>> call(String query) {
    return _placesRepository.searchPlaces(query);
  }
}
