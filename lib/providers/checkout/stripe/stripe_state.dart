import 'package:flutter/material.dart';
import 'package:mobile_coffee_shop/providers/checkout/stripe/stripe_result.dart';

@immutable
class StripeState {
  final StripeResult? result;
  final bool isLoading;

  const StripeState({
    required this.result,
    required this.isLoading,
  });

  const StripeState.unknown()
      : result = null,
        isLoading = false;

  StripeState copiedWithIsLoading(bool isLoading) => StripeState(
        result: result,
        isLoading: isLoading,
      );

  @override
  bool operator ==(covariant StripeState other) =>
      identical(this, other) ||
      (result == other.result && isLoading == other.isLoading);

  @override
  int get hashCode => Object.hash(
        result,
        isLoading,
      );
}
