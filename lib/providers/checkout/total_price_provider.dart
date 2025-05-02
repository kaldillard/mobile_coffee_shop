import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_coffee_shop/providers/checkout/cart_counter_provider.dart';
import 'package:mobile_coffee_shop/providers/checkout/delivery_fee_provider.dart';

final totalWithDeliveryProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  final deliveryFee = ref.watch(deliveryFeeProvider);

  final subtotal = cart.fold(
    0.0,
    (sum, item) => sum + item.quantity * item.coffee.price!,
  );

  return subtotal + deliveryFee;
});
