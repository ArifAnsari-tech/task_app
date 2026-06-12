import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/item_provider.dart';
import 'package:task_app/screens/product_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ItemProvider()
        ..aadWishlist()
        ..fetchItems(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductScreen(),
    );
  }
}
