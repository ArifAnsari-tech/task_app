
# Task App

This is a Flutter application that displays products from an API with pagination, search, filter, 
product details, and wishlist functionality.

## Features

-> API Integration using Dio
-> State Management using Provider
-> Infinite Scroll Pagination
-> Product Search
-> Product Price Filter
-> Product Detail Screen
-> Wishlist using SharedPreferences
-> Error Handling
-> Clean Code Structure

## Project Structure

lib/
├── models/
│   └── products_model.dart
├── providers/
│   └── item_provider.dart
├── screens/
│   ├── product_screen.dart
│   └── product_detail_screen.dart
├── services/
│   └── api_service.dart
└── main.dart


## API Used

https://dummyjson.com/products

## Dependencies

-> provider
-> dio
-> shared_preferences



## Functionality

### Product Listing

Fetched products from API and displays them in a scrollable list.

### Pagination

Loads additional products when user reaches the bottom of the list.

### Search

Search products by title.

### Filter

Filter products based on price.

### Product Details

Displays detailed information of selected product.

### Wishlist

Users can add/remove products from wishlist. Wishlist data is stored locally using SharedPreferences.

### DSA Solutions:
- Two Sum Variant
- Longest Substring Without Repeating Characters

### Practical Questions:
- API Call and List Display
- Pagination
- Debounce Function
- Reverse String
- Duplicate Elements

## Author

Arif Ansari

