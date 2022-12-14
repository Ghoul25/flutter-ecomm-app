import 'package:ecommerce_app/common/widgets/loader.dart';
import 'package:ecommerce_app/features/home/services/home_services.dart';
import 'package:ecommerce_app/features/product_details/screens/product_details_screen.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class DailyDeals extends StatefulWidget {
  const DailyDeals({super.key});

  @override
  State<DailyDeals> createState() => _DailyDealsState();
}

class _DailyDealsState extends State<DailyDeals> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDailyDeals();
  }

  void fetchDailyDeals() async {
    product = await homeServices.fetchDailyDeals(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailsScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 20, top: 15, bottom: 10),
                      child: const Text(
                        'Dealy Deals',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    // Container(
                    //   padding: const EdgeInsets.only(left: 15),
                    //   alignment: Alignment.center,
                    //   child: const Text(
                    //     'Click on the product for more info',
                    //     style: TextStyle(
                    //       fontSize: 18,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          left: 15, top: 15, right: 40, bottom: 10),
                      child: const Text(
                        'Click on the product for more info',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map(
                              (e) => Image.network(
                                e,
                                fit: BoxFit.fitWidth,
                                width: 100,
                                height: 100,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Deal ends soon!',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              );
  }
}
