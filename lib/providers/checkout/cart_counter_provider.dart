import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_coffee_shop/models/cart_item_model.dart';
import 'package:mobile_coffee_shop/providers/checkout/cart_notifier.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});
