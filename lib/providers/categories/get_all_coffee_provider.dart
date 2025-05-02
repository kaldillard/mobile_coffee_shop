import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_coffee_shop/models/coffee_model.dart';
import 'package:mobile_coffee_shop/providers/api_provider.dart';

final getAllCoffeeProvider = FutureProvider<Iterable<Coffee>>((ref) async {
  return ref.read(apiProvider).getCoffee();
});
