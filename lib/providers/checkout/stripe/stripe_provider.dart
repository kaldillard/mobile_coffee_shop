import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_coffee_shop/services/stripe_service.dart';

final stripeProvider = Provider<PaymentService>((ref) => PaymentService());
