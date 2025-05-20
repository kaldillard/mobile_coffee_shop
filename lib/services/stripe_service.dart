import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile_coffee_shop/models/coffee_model.dart';

final dio = Dio();

class PaymentService {
  final Dio dio;

  PaymentService()
      : dio = Dio(BaseOptions(
            baseUrl: 'http://127.0.0.1:3000',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Content-Type': 'application/json',
            }));

  Future<String?> createPaymentIntent(int amount) async {
    try {
      final response = await dio.post(
        '/create-payment-intent',
        data: {'amount': amount, 'currency': 'usd'},
      );
      if (response.statusCode == 200) {
        final jsonResponse =
            response.data as Map<String, dynamic>; // Cast to Map
        print("Received response: $jsonResponse");
        return jsonResponse["clientSecret"]
            as String; // Access the clientSecret key
      } else {
        print('Failed to get clientSecret: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
