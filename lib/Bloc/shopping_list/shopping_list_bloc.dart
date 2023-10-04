import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/Bloc/shopping_list/shopping_list_event.dart';
import 'package:shopping_cart/Bloc/shopping_list/shopping_list_state.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_cart/Data/shopping_list_data.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListBloc() : super(ShoppingListInitialState()) {
    on<GetShoppingListEvent>(getShoppingListEvent);
    on<ShowCartEvent>(showCartDetails);
  }

  late List<ShoppingListData> shoppingList;

  Future<void> getShoppingListEvent(
      GetShoppingListEvent event, Emitter<ShoppingListState> emit) async {
    var client = http.Client();

    try {
      var response =
          await client.get(Uri.parse('https://fakestoreapi.com/products'));
      final List<dynamic> parsedJson = json.decode(response.body);
      shoppingList = parsedJson
          .map((jsonItem) => ShoppingListData.fromJson(jsonItem))
          .toList();
      debugPrint(shoppingList.toString());
      emit(ShoppingListFetchedState(shoppingList: shoppingList));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showCartDetails(ShowCartEvent event, Emitter<ShoppingListState> emit) {
    var cartItems = getCartItems();
    emit(ShowCartDetailsState(cartItems: cartItems));
  }

  List<ShoppingListData> getCartItems() {
    List<ShoppingListData> cartData = [];
    for (ShoppingListData shoppingData in shoppingList) {
      if (shoppingData.cartCount > 0) {
        cartData.add(shoppingData);
      }
    }
    return cartData;
  }
}
