import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  void toggleFavoriteStatus() async {
    final oldStatus = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
        'https://flutter-learning-7d661-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json');
    try {
      final res =
          await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
      if (res.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
