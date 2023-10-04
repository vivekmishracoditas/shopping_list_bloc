import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/Bloc/Cart/cart_event.dart';
import 'package:shopping_cart/Bloc/Cart/cart_state.dart';
import 'package:shopping_cart/Data/shopping_list_data.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<GetCartItemsEvent>(getCartItems);
  }

  Future<void> getCartItems(
      GetCartItemsEvent event, Emitter<CartState> emit) async {
    List<ShoppingListData> cartItems = [];

    try {
      // var response =
      //     await client.get(Uri.parse('https://fakestoreapi.com/products'));
      // final List<dynamic> parsedJson = json.decode(response.body);
      // shoppingList = parsedJson
      //     .map((jsonItem) => ShoppingListData.fromJson(jsonItem))
      //     .toList();
      debugPrint(cartItems.toString());
      emit(
        CartFetchedState(cartItems: cartItems),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
