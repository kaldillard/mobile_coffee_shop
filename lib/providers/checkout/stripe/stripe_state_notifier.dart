import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mobile_coffee_shop/providers/checkout/stripe/stripe_provider.dart';
import 'package:mobile_coffee_shop/services/stripe_service.dart';

class StripeStateNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  StripeStateNotifier(this.ref) : super(const AsyncData(null));

  // Future<void> makePayment(String email) async {
  //   state = const AsyncLoading();
  //   try {
  //     final paymentService = ref.read(stripeProvider);
  //     await paymentService.createPaymentIntent(1000);
  //     state = const AsyncData(null); // or pass a result value
  //   } catch (e, st) {
  //     state = AsyncError(e, st);
  //   }
  // }

  Future<void> makePayment(int amount) async {
    try {
      // Step 1: Request Payment Intent from Backend
      String? clientSecret =
          await PaymentService().createPaymentIntent(amount); // Amount in cents

      if (clientSecret == null) {
        print("Failed to get clientSecret");
        return;
      }

      // Step 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "My Store",
        ),
      );

      // Step 3: Show Payment Sheet
      await Stripe.instance.presentPaymentSheet();

      print("Payment Successful!");
    } catch (e) {
      print("Payment Failed: $e");
    }
  }
}
