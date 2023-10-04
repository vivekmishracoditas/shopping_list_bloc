import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/Bloc/Cart/cart_bloc.dart';
import 'package:shopping_cart/Bloc/shopping_list/shopping_list_bloc.dart';
import 'package:shopping_cart/Screens/shopping_list_home_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ShoppingListBloc>(
          create: (BuildContext context) => ShoppingListBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (BuildContext context) => CartBloc(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shopping List',
      debugShowCheckedModeBanner: false,
      home: ShoppingListHomePage(),
    );
  }
}
