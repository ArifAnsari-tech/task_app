import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/screens/pt_detail_screen.dart';
import '../providers/item_provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<ItemProvider>().fetchItems();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {

              if (value == "wishlist") {
                context.read<ItemProvider>().showWishlist();
              }

              else if (value == "100") {
                context.read<ItemProvider>().filterByPrice(100);
              }

              else if (value == "500") {
                context.read<ItemProvider>().filterByPrice(500);
              }

              else if (value == "all") {
                context.read<ItemProvider>().resetFilter();
              }
            },

            itemBuilder: (context) => [

              const PopupMenuItem(
                value: "wishlist",
                child: Text("Wishlist"),
              ),

              const PopupMenuItem(
                value: "100",
                child: Text("Price < 100"),
              ),

              const PopupMenuItem(
                value: "500",
                child: Text("Price < 500"),
              ),

              const PopupMenuItem(
                value: "all",
                child: Text("Show All"),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          /// search_bar
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search Product",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<ItemProvider>().searchProduct(value);
              },
            ),
          ),

          /// product_lists
          Expanded(
            child: Consumer<ItemProvider>(
              builder: (context, provider, child) {
                if (provider.filteredProducts.isEmpty && provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  controller: scrollController,
                  itemCount: provider.filteredProducts.length + 1,
                  itemBuilder: (context, index) {
                    if (index < provider.filteredProducts.length) {
                      final item = provider.filteredProducts[index];

                      return Card(
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            trailing: IconButton(
                              icon: Padding(
                                padding: const EdgeInsets.only(left:20.0),
                                child: Icon(
                                  provider.isWishlisted(item.id)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                              onPressed: () {
                                provider.toggleWishlist(item.id);
                              },
                            ),
                            leading: Image.network(
                              item.thumbnail,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            title: Text(item.title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            subtitle: Text(
                              "₹${item.price}",
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailScreen(item: item),
                                ),
                              );
                            },
                          ));
                    }

                    return provider.isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
