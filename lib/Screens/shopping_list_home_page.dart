// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/Bloc/Cart/cart_bloc.dart';
import 'package:shopping_cart/Bloc/Cart/cart_event.dart';
import 'package:shopping_cart/Bloc/Cart/cart_state.dart';
import 'package:shopping_cart/Bloc/shopping_list/shopping_list_bloc.dart';
import 'package:shopping_cart/Bloc/shopping_list/shopping_list_event.dart';
import 'package:shopping_cart/Bloc/shopping_list/shopping_list_state.dart';
import 'package:shopping_cart/Data/shopping_list_data.dart';
import 'package:shopping_cart/Screens/cart_items_screen.dart';

class ShoppingListHomePage extends StatefulWidget {
  const ShoppingListHomePage({super.key});

  @override
  State<ShoppingListHomePage> createState() => _ShoppingListHomePageState();
}

class _ShoppingListHomePageState extends State<ShoppingListHomePage> {
  @override
  void initState() {
    BlocProvider.of<ShoppingListBloc>(context).add(GetShoppingListEvent());
    addBlockListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              print('Cart Button  Tapped');
              BlocProvider.of<ShoppingListBloc>(context).add(ShowCartEvent());
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: BlocConsumer<ShoppingListBloc, ShoppingListState>(
        buildWhen: (previous, current) =>
            current is ShoppingListFetchedState ||
            current is ShoppingListInitialState,
        listenWhen: (previous, current) => current is ShowCartDetailsState,
        builder: (context, state) {
          print(state);
          if (state is ShoppingListFetchedState) {
            return getShoppingListCards(context, state.shoppingList);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        listener: (context, state) {
          if (state is ShowCartDetailsState) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CartItemsPage(cartItems: state.cartItems),
              ),
            );
          }
        },
      ),
    );
  }

  Widget getShoppingList(
      BuildContext context, List<ShoppingListData> shoppingList) {
    return ListView.builder(
      itemCount: shoppingList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(shoppingList[index].image),
          title: Text(shoppingList[index].title),
          subtitle: Text(shoppingList[index].description),
        );
      },
    );
  }

  Widget getShoppingListCards(
      BuildContext context, List<ShoppingListData> shoppingList) {
    return ListView.builder(
      itemCount: shoppingList.length,
      itemBuilder: (context, index) {
        ShoppingListData data = shoppingList[index];
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
                          child: Text('\$ ${data.price}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Ink(
                                    decoration: const ShapeDecoration(
                                      color: Color.fromARGB(255, 212, 207, 207),
                                      shape: CircleBorder(),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        if (shoppingList[index].itemCount > 0) {
                                          setState(() {
                                            shoppingList[index].itemCount -= 1;
                                          });
                                        }
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${data.itemCount}',
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  Ink(
                                    decoration: const ShapeDecoration(
                                      color: Color.fromARGB(255, 212, 207, 207),
                                      shape: CircleBorder(),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          shoppingList[index].itemCount += 1;
                                        });
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    shoppingList[index].cartCount +=
                                        shoppingList[index].itemCount;
                                    shoppingList[index].itemCount = 0;
                                  });
                                },
                                child: const Text('Add'),
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

  void addBlockListener() {
    BlocListener<ShoppingListBloc, ShoppingListState>(
      listener: (context, state) {
        if (state is ShowCartDetailsState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CartItemsPage(cartItems: state.cartItems),
            ),
          );
        }
      },
    );
  }
}
