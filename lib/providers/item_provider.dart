import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/products_model.dart';
import '../services/api_service.dart';

class ItemProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  List<Items> products = [];
  List<Items> filteredProducts = [];

  List<int> wishlist = [];

  bool isLoading = false;
  int skip = 0;

  Future<void> fetchItems() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    final result = await apiService.getItems(10, skip);

    products.addAll(result);

    filteredProducts = List.from(products);

    skip += 10;

    isLoading = false;
    notifyListeners();
  }

  /// searching
  void searchProduct(String query) {
    if (query.isEmpty) {
      filteredProducts = List.from(products);
    } else {
      filteredProducts = products.where((item) {
        return item.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  /// apply filter
  void filterByPrice(double maxPrice) {
    filteredProducts = products.where((item) {
      return item.price <= maxPrice;
    }).toList();

    notifyListeners();
  }
  void showWishlist() {
    filteredProducts = products.where((item) {
      return wishlist.contains(item.id);
    }).toList();

    notifyListeners();
  }

  /// reset filters
  void resetFilter() {
    filteredProducts = List.from(products);
    notifyListeners();
  }

  /// wishlist
  Future<void> aadWishlist() async {
    final prefs = await SharedPreferences.getInstance();

    wishlist = prefs.getStringList('wishlist')?.map(int.parse).toList() ?? [];

    notifyListeners();
  }

  Future<void> toggleWishlist(int productId) async {

    final prefs = await SharedPreferences.getInstance();

    if (wishlist.contains(productId)) {
      wishlist.remove(productId);
    } else {
      wishlist.add(productId);
    }

    await prefs.setStringList(
      'wishlist',
      wishlist.map((e) => e.toString()).toList(),
    );

    notifyListeners();
  }

  bool isWishlisted(int productId) {
    return wishlist.contains(productId);
  }
}
