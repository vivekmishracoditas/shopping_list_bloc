import 'package:flutter/material.dart';
import 'package:shopping_cart/Data/shopping_list_data.dart';

// ignore: must_be_immutable
class CartItemsPage extends StatefulWidget {
  CartItemsPage({super.key, required this.cartItems});
  List<ShoppingListData> cartItems;

  @override
  State<CartItemsPage> createState() => _CartItemsPageState();
}

class _CartItemsPageState extends State<CartItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: getCartItems(context, widget.cartItems));
  }

  Widget getCartItems(BuildContext context, List<ShoppingListData> cartItems) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        ShoppingListData data = cartItems[index];
        return Container(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          width: double.infinity,
          height: 200,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  child: Image.network(data.image),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            data.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                              'Total Cost: \$ ${data.price * data.cartCount}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Quantity: ${data.cartCount}',
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    data.cartCount = 0;
                                  });
                                },
                                child: const Text('Remove'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
