import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_coffee_shop/constants/colors.dart';
import 'package:mobile_coffee_shop/components/home/coffee_list_widget.dart';
import 'package:mobile_coffee_shop/components/placholders/coffee_list_placeholder.dart';
import 'package:mobile_coffee_shop/models/location_list_model.dart';
import 'package:mobile_coffee_shop/providers/categories/get_latte_provider.dart';
import 'package:mobile_coffee_shop/providers/checkout/total_quantity_provider.dart';
import 'package:mobile_coffee_shop/providers/location_state_provider.dart';
import 'package:mobile_coffee_shop/screens/shopping_cart_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Map<String, bool> categories = {
    "All Coffee": true,
    "Latte": false,
    "Frappe": false,
    "Americano": false,
  };

  @override
  Widget build(BuildContext context) {
    final coffeeList = ref.watch(filteredCoffeeProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final totalQuantity = ref.watch(totalQuantityProvider);
    final locationList = ref.watch(pickupLocationsProvider);
    final selectedLocation = ref.watch(selectedLocationStateProvider);
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height / 3,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Colors.grey.shade800, Colors.grey.shade900],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Location",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: locationList.map((location) {
                                      return DropdownMenuItem<LocationList>(
                                        value: location,
                                        child: Text(location.label),
                                      );
                                    }).toList(),
                                    onChanged: (location) {
                                      ref
                                          .read(selectedLocationStateProvider
                                              .notifier)
                                          .state = location;
                                    },
                                    value: selectedLocation,
                                    style: TextStyle(
                                        color: Colors.grey.shade300,
                                        fontWeight: FontWeight.bold),
                                    dropdownColor: color03,
                                    hint: const Text(
                                      "Choose Location",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              iconSize: 24,
                              color: Colors.grey.shade300,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ShoppingCartScreen();
                                    },
                                  ),
                                );
                              },
                              icon: Badge.count(
                                count: totalQuantity,
                                child: const Icon(IconlyBold.bag),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 275,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    IconlyLight.search,
                                    color: Colors.grey.shade300,
                                  ),
                                  labelText: "Search coffee",
                                  labelStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  fillColor: Colors.grey.shade800,
                                  filled: true,
                                ),
                                style: TextStyle(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            IconButton.filled(
                              onPressed: () {},
                              icon: const Icon(
                                IconlyLight.filter,
                              ),
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -85,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                      height: 150,
                      width: MediaQuery.sizeOf(context).width - 40,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: Image.asset(
                          'assets/coffeePromo.png',
                          width: MediaQuery.sizeOf(context).width,
                          height: 128,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.entries.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 20,
                    ),
                    itemBuilder: (context, index) {
                      var isActive = categories.values.elementAt(index);
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            categories.updateAll((key, value) => value = false);
                            categories.update(categories.keys.elementAt(index),
                                (value) => true);
                          });
                          ref.read(selectedCategoryProvider.notifier).state =
                              categories.keys.elementAt(index);
                        },
                        style: isActive == true
                            ? TextButton.styleFrom(
                                backgroundColor: color01,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))
                            : TextButton.styleFrom(
                                backgroundColor: Colors.grey.shade200,
                                foregroundColor: color03,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                        child: Text(categories.keys.elementAt(index)),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                coffeeList.when(
                  data: (coffees) {
                    if (selectedCategory != "All Coffee") {
                      var newCoffee = coffees
                          .where((coffee) =>
                              coffee.title!.contains(selectedCategory))
                          .toList();

                      return CoffeeList(
                        coffees: newCoffee,
                      );
                    }
                    return CoffeeList(
                      coffees: coffees,
                    );
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 20,
                      ),
                    );
                  },
                  loading: () {
                    return const CoffeeListPlaceholder();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
