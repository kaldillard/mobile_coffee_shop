import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_coffee_shop/providers/checkout/stripe/stripe_state.dart';
import 'package:mobile_coffee_shop/providers/checkout/stripe/stripe_state_notifier.dart';

final stripeStateProvider =
    StateNotifierProvider<StripeStateNotifier, AsyncValue<void>>((ref) {
  return StripeStateNotifier(ref);
});
