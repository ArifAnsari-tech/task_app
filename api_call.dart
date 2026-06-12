import 'package:dio/dio.dart';
import 'package:task_app/models/products_model.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<Items>> getItems() async {

    final response = await dio.get(
      'https://dummyjson.com/products',
    );

    List data = response.data['products'];

    return data
        .map((e) => Items.fromJson(e))
        .toList();
  }
}