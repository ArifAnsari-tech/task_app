import 'package:flutter/material.dart';
import 'package:task_app/providers/item_provider.dart';

class DisplayList extends StatefulWidget{
  const DisplayList({super.key});

  @override
  State<DisplayList> createState() => _DisplayListState();

}

class _DisplayListState extends State<DisplayList>{

  final provider = ItemProvider();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: provider.products.length,
      itemBuilder: (context, index) {

        final item =
        provider.products[index];

        return ListTile(
          title: Text(item.title),
          subtitle: Text(
            "₹${item.price}",
          ),
        );
      },
    );
  }



}