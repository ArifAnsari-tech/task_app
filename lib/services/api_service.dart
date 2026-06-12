import 'package:dio/dio.dart';
import '../models/products_model.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<Items>> getItems(int limit, int skip) async {
    try {
      final response = await dio.get(
        'https://dummyjson.com/products',
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
      );

      List data = response.data['products'];

      return data.map((e) => Items.fromJson(e)).toList();

    } catch (e) {
      throw Exception(e.toString());
    }
  }
}