import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_coffee_shop/services/coffee_service.dart';

final apiProvider = Provider<CoffeeService>((ref) => CoffeeService());
