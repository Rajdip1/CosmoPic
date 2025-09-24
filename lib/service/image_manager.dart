import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/api_model.dart';

class ImageManager extends ChangeNotifier {
  static final ImageManager _instance = ImageManager._internal();
  factory ImageManager() => _instance;

  ImageManager._internal() {
    _loadFavorites();
  }

  final List<APIModel> _favorites = [];
  static const _favoritesKey = 'favorites';

  List<APIModel> get favorites => List.unmodifiable(_favorites);

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesString = prefs.getString(_favoritesKey);
    if (favoritesString != null) {
      final List<dynamic> favoriteList = jsonDecode(favoritesString);
      _favorites.clear();
      _favorites.addAll(favoriteList.map((e) => APIModel.fromJson(e as Map<String, dynamic>)));
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesString = jsonEncode(_favorites.map((e) => e.toJson()).toList());
    await prefs.setString(_favoritesKey, favoritesString);
  }

  Future<void> add(APIModel model) async {
    if (!_favorites.any((item) => item.date == model.date)) {
      _favorites.add(model);
      await _saveFavorites();
      notifyListeners();
    }
  }

  Future<void> remove(APIModel model) async {
    _favorites.removeWhere((item) => item.date == model.date);
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> clear() async {
    _favorites.clear();
    await _saveFavorites();
    notifyListeners();
  }
}
