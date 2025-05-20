import 'package:dio/dio.dart';
import 'package:mobile_coffee_shop/models/coffee_model.dart';

final dio = Dio();

void getCategories() async {
  Response response;

  response = await dio.get(
    '/api/recipes?category=HOT%20BEVERAGES',
  );
  // ignore: avoid_print
  print(response.data.toString());
}

class CoffeeService {
  final dio = Dio();
  BaseOptions options = BaseOptions(
    baseUrl: 'https://api.sampleapis.com/coffee/iced',
    method: 'GET',
  );

  // BaseOptions restaurantDetailOptions = BaseOptions(
  //   baseUrl: 'https://worldwide-restaurants.p.rapidapi.com/detail',
  //   headers: {
  //     'x-rapidapi-key': 'b6e9b93d2amsh71761c27b269ac6p177525jsn2fd44ca42b20',
  // 	'x-rapidapi-host': 'starbucks-coffee-db2.p.rapidapi.com'
  //   },
  //   method: 'GET',
  // );

  Future<Iterable<Coffee>> getCoffee() async {
    final coffeeData = await dio
        .get(
          options.baseUrl,
          options: Options(
            method: options.method,
          ),
        )
        .catchError(() {});

    dynamic body = coffeeData.data;

    Iterable<Coffee> coffee = (body as List).map((e) => Coffee.fromJson(e));

    //List<Coffee>.fromJson(body[0]);

    // print("Coffee is : ${coffee.title}");

    return coffee;
  }

  // Future<RestaurantDetails> getRestaurantDetails(String locationid) async {
  //   final restaurantsDetailsData = await dio
  //       .post(restaurantDetailOptions.baseUrl,
  //           queryParameters: {
  //             'currency': 'USD',
  //             'language': 'en_US',
  //             'location_id': locationid,
  //           },
  //           options: Options(
  //             headers: restaurantDetailOptions.headers,
  //             method: restaurantDetailOptions.method,
  //           ))
  //       .catchError(() {});

  //   dynamic body = restaurantsDetailsData.data;

  //   RestaurantDetails restaurantDetails = RestaurantDetails.fromJson(body);

  //   return restaurantDetails;
  // }
}
