import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

abstract class IMenuRepository {
  Future<List<Product>> fetchProducts();
}

class HttpMenuRepository implements IMenuRepository {
  // Usaremos a Fake Store API como exemplo didático de REST
  final String _url = 'https://fakestoreapi.com/products/category/electronics';

  @override
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar cardápio');
    }
  }
}