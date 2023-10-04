import 'package:shopping_cart/Data/shopping_list_data.dart';

class CartState {}

class CartInitialState extends CartState {}

class CartFetchedState extends CartState {
  final List<ShoppingListData> cartItems;

  CartFetchedState({required this.cartItems});
}

class ItemAddedToCart extends CartState {
  final ShoppingListData item;
  final int quantity;

  ItemAddedToCart({required this.item, required this.quantity});
}
