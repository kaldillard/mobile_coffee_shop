import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_coffee_shop/providers/checkout/cart_counter_provider.dart';

final subtotalPriceProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(
    0,
    (sum, item) => sum + item.quantity * 4.25,
  );
});
