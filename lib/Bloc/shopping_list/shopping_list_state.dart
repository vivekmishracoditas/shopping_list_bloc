import 'package:shopping_cart/Data/shopping_list_data.dart';

class ShoppingListState {}

class ShoppingListInitialState extends ShoppingListState {}

class ShoppingListFetchedState extends ShoppingListState {
  final List<ShoppingListData> shoppingList;

  ShoppingListFetchedState({required this.shoppingList}) {
    print("ShoppingListFetchedState state triggered");
  }
}

class ShowCartDetailsState extends ShoppingListState {
  final List<ShoppingListData> cartItems;

  ShowCartDetailsState({required this.cartItems});
}
