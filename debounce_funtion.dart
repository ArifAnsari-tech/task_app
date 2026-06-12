import 'dart:async';

class SearchHelper {

  Timer? debounce;

  void search(String query) {

    if (debounce?.isActive ?? false) {
      debounce!.cancel();
    }

    debounce = Timer(
      const Duration(milliseconds: 500),
          () {
        print("Searching: $query");
      },
    );
  }
}