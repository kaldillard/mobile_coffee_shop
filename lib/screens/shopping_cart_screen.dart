import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_coffee_shop/constants/colors.dart';
import 'package:mobile_coffee_shop/models/location_list_model.dart';
import 'package:mobile_coffee_shop/providers/checkout/cart_counter_provider.dart';
import 'package:mobile_coffee_shop/providers/checkout/delivery_fee_provider.dart';
import 'package:mobile_coffee_shop/providers/checkout/stripe/stripe_state_provider.dart';
import 'package:mobile_coffee_shop/providers/checkout/subtotal_price_provider.dart';
import 'package:mobile_coffee_shop/providers/checkout/total_price_provider.dart';
import 'package:mobile_coffee_shop/providers/location_state_provider.dart';
import 'package:mobile_coffee_shop/screens/delivery_screen.dart';

class ShoppingCartScreen extends ConsumerStatefulWidget {
  ShoppingCartScreen({
    super.key,
  });

  @override
  ConsumerState<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends ConsumerState<ShoppingCartScreen> {
  increment(coffee) {
    setState(() {
      ref.read(cartProvider.notifier).addCoffee(coffee);
    });
  }

  decrement(coffee) {
    setState(() {
      ref.read(cartProvider.notifier).decreaseQuantity(coffee);
    });
  }

  List<DataTab> get _listGenderText => [
        DataTab(
          title: "Delivery",
        ),
        DataTab(
          title: "Pickup",
        ),
      ];

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final subtotalPrice = ref.watch(subtotalPriceProvider);
    final deliveryFee = ref.watch(deliveryFeeProvider);
    final totalPrice = ref.watch(totalWithDeliveryProvider);
    final locationList = ref.watch(pickupLocationsProvider);
    final selectedLocation = ref.watch(selectedLocationStateProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          "Order",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlutterToggleTab(
              width: 87,
              borderRadius: 16,
              selectedBackgroundColors: const [color01],
              selectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              unSelectedTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              dataTabs: _listGenderText,
              selectedIndex: _selectedTab,
              selectedLabelIndex: (index) {
                setState(() {
                  _selectedTab = index;
                });
              },
            ),

            const SizedBox(
              height: 20,
            ),
            _selectedTab == 0
                ? const DeliveryAddress(
                    name: "John Doe",
                    address: "123 Fake Rd, Anytown, PA 17101",
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pick Up Location",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: color04),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<LocationList>(
                            items: locationList.map((location) {
                              return DropdownMenuItem<LocationList>(
                                value: location,
                                child: Text(
                                  location.label,
                                ),
                              );
                            }).toList(),
                            onChanged: (location) {
                              ref
                                  .read(selectedLocationStateProvider.notifier)
                                  .state = location;
                            },
                            value: selectedLocation,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            icon: Text(
                              "Change",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.grey.shade700),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

            const SizedBox(
              height: 16,
            ),
            const Divider(
              color: color04,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final item = cart[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: Image.network(
                          item.coffee.image!,
                          fit: BoxFit.cover,
                          height: 54,
                          width: 54,
                        )),
                    title: Text(
                      item.coffee.title!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "\$${(item.quantity * 4.25).toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          constraints: const BoxConstraints(maxHeight: 24),
                          padding: EdgeInsets.zero,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            ref
                                .read(cartProvider.notifier)
                                .decreaseQuantity(item.coffee);
                          },
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          '${item.quantity}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        IconButton(
                          constraints: const BoxConstraints(maxHeight: 24),
                          padding: EdgeInsets.zero,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            ref
                                .read(cartProvider.notifier)
                                .addCoffee(item.coffee);
                          },
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: cart.length,
              ),
            ),
            // SizedBox(
            //   width: MediaQuery.sizeOf(context).width,
            //   child: OverflowBox(
            //     maxWidth: MediaQuery.sizeOf(context).width,
            //     child: const Divider(
            //       color: color02,
            //       thickness: 4,
            //     ),
            //   ),
            // ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: color04),
              ),
              leading: const Icon(
                IconlyLight.discount,
                color: color01,
              ),
              title: const Text(
                "No Discount Available",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(IconlyLight.arrow_right_2),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Payment Summary",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Price"),
                Text(
                  '\$${subtotalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Delivery Fee",
                ),
                Text(
                  '\$${deliveryFee.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: ShoppingCartBottomNavigation(
        totalPrice: totalPrice,
        subtotalPrice: subtotalPrice,
      ),
    );
  }
}

class DeliveryAddress extends StatelessWidget {
  final String name;
  final String address;
  const DeliveryAddress({
    super.key,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Delivery Address",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          address,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            DeliveryButton(
              title: "Edit Address",
              icon: IconlyLight.edit_square,
              onPressed: () {},
            ),
            const SizedBox(
              width: 10,
            ),
            DeliveryButton(
              title: "Add Note",
              icon: IconlyLight.paper,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class ShoppingCartBottomNavigation extends ConsumerWidget {
  const ShoppingCartBottomNavigation({
    super.key,
    required this.totalPrice,
    required this.subtotalPrice,
  });

  final double totalPrice;
  final double subtotalPrice;

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(stripeStateProvider);
    return Container(
      height: 165,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24.0,
          right: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 327,
              height: 39,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  IconlyLight.wallet,
                  color: color01,
                ),
                title: const Text(
                  "Cash/Wallet",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "\$${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: color01,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(IconlyLight.arrow_down_2),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            SizedBox(
              height: 56,
              width: MediaQuery.sizeOf(context).width,
              child: FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: color01,
                    disabledBackgroundColor: color04,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: subtotalPrice == 0
                    ? null
                    : () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return const DeliveryScreen();
                        // }));
                        ref
                            .read(stripeStateProvider.notifier)
                            .makePayment((totalPrice * 100).toInt());
                      },
                child: const Text("Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeliveryButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final IconData icon;
  const DeliveryButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        label: Text(
          title,
          style: const TextStyle(fontSize: 12),
        ),
        icon: Icon(
          icon,
          size: 14,
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}
