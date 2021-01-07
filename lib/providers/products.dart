import 'package:flutter/material.dart';
import './product.dart';
import 'package:dio/dio.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  String baseUrl = 'http://192.168.0.70:1337/products';

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return items.where((el) => el.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> getProducts() async {
    try {
      final response = await Dio().get(baseUrl);
      final extractedData = response.data;
      if (extractedData == null) return;
      final List<Product> loadedProducts = [];
      extractedData.forEach((el) {
        loadedProducts.add(Product(
            id: el['id'].toString(),
            title: el['title'],
            description: el['description'],
            price: el['price'],
            imageUrl: el['imageUrl'],
            isFavorite: el['isFavorite']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await Dio().post(baseUrl, data: {
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'id': DateTime.now().toString(),
      });
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: DateTime.now().toString(),
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex != -1) {
      await Dio().put('$baseUrl/$id', data: {
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
        'id': DateTime.now().toString(),
        'isFavorite':newProduct.isFavorite,
      });
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await Dio().delete('$baseUrl/$id');
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
    
  }
}
