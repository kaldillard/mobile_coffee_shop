import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_coffee_shop/constants/colors.dart';
import 'package:mobile_coffee_shop/components/add_to_cart_widget.dart';
import 'package:mobile_coffee_shop/components/details/detail_icon_widget.dart';
import 'package:mobile_coffee_shop/models/coffee_model.dart';
import 'package:mobile_coffee_shop/providers/checkout/cart_counter_provider.dart';
import 'package:mobile_coffee_shop/providers/checkout/total_quantity_provider.dart';
import 'package:mobile_coffee_shop/screens/shopping_cart_screen.dart';

class CoffeeDetailsScreen extends ConsumerStatefulWidget {
  final Coffee coffee;
  const CoffeeDetailsScreen({
    super.key,
    required this.coffee,
  });

  @override
  ConsumerState<CoffeeDetailsScreen> createState() =>
      _CoffeeDetailsScreenState();
}

class _CoffeeDetailsScreenState extends ConsumerState<CoffeeDetailsScreen> {
  Map<String, bool> sizes = {
    "S": false,
    "M": true,
    "L": false,
  };

  bool isLike = false;
  String currentSize = "M";

  String displayIngredeints() {
    if (widget.coffee.ingredients!.isEmpty) {
      return "N/A";
    } else {
      return widget.coffee.ingredients![0].toLowerCase();
    }
  }

  void increment() {
    setState(() {
      ref.read(cartProvider.notifier).addCoffee(widget.coffee);
    });
  }

  void decrement() {
    setState(() {
      ref.read(cartProvider.notifier).decreaseQuantity(widget.coffee);
    });
  }

  int isCartActive() {
    final cartItems = ref.watch(cartProvider);

    final index =
        cartItems.indexWhere((item) => item.coffee.id == widget.coffee.id);

    if (index != -1) {
      return cartItems[index].quantity;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalQuantity = ref.watch(totalQuantityProvider);

    return Scaffold(
      backgroundColor: color04,
      appBar: AppBar(
        backgroundColor: color04,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(IconlyLight.arrow_left_2),
        ),
        title: const Text(
          "Detail",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isLike = !isLike;
              });
            },
            icon: isLike
                ? const Icon(
                    IconlyBold.heart,
                    size: 30,
                    color: color01,
                  )
                : const Icon(
                    IconlyLight.heart,
                    size: 30,
                  ),
          ),
          IconButton(
            iconSize: 30,
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
              child: const Icon(IconlyLight.bag),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: SizedBox.fromSize(
                  child: Image.network(
                    widget.coffee.image!,
                    width: MediaQuery.sizeOf(context).width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.coffee.title!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        displayIngredeints(),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Row(
                    children: [
                      DetailIcon(
                        image: "assets/ride.png",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DetailIcon(
                        image: "assets/coffeeBean.png",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DetailIcon(
                        image: "assets/milk.png",
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    IconlyBold.star,
                    color: Colors.yellow.shade800,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    "4.8",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Text(
                    "(230)",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.coffee.description!,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Size",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var isActive = sizes.values.elementAt(index);
                      return SizedBox(
                        width: 100,
                        child: TextButton(
                          onPressed: () {
                            currentSize = sizes.keys.elementAt(index);
                            setState(() {
                              sizes.updateAll((key, value) => value = false);
                              sizes.update(
                                  sizes.keys.elementAt(index), (value) => true);
                            });
                          },
                          style: isActive == true
                              ? TextButton.styleFrom(
                                  backgroundColor:
                                      color01.withValues(alpha: .1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(color: color01)),
                                )
                              : TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side:
                                          const BorderSide(color: Colors.grey)),
                                ),
                          child: Text(
                            sizes.keys.elementAt(index),
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    isActive == true ? color01 : Colors.black),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 20,
                      );
                    },
                    itemCount: sizes.entries.length),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 92,
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Price",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "\$${widget.coffee.price!.toStringAsPrecision(3)}",
                    style: const TextStyle(
                        color: color01,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              AddToCartWidget(
                coffee: widget.coffee,
                isCart: isCartActive(),
                increment: increment,
                decrement: decrement,
              )
            ],
          ),
        ),
      ),
    );
  }
}
