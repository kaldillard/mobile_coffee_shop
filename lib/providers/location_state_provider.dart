import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_coffee_shop/models/location_list_model.dart';

final pickupLocationsProvider = Provider<List<LocationList>>(
  (ref) {
    return [
      LocationList(1, "Charlotte, North Carolina"),
      LocationList(2, "Raleigh, North Carolina"),
      LocationList(3, "Greensboro, North Carolina"),
    ];
  },
);

final selectedLocationStateProvider =
    StateProvider<LocationList?>((ref) => null);
