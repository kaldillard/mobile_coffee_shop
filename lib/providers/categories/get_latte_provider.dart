import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_coffee_shop/models/coffee_model.dart';
import 'package:mobile_coffee_shop/providers/categories/get_all_coffee_provider.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => 'All Coffee');

final filteredCoffeeProvider = Provider<AsyncValue<Iterable<Coffee>>>((ref) {
  final coffeeList = ref.watch(getAllCoffeeProvider);

  return coffeeList;
});
