import 'package:flutter/foundation.dart';
import '../model/api_model.dart';

class ImageManager extends ChangeNotifier {
  static final ImageManager _instance = ImageManager._internal();
  factory ImageManager() => _instance;

  ImageManager._internal();

  final List<APIModel> _favorites = [];

  List<APIModel> get favorites => List.unmodifiable(_favorites);

  void add(APIModel model) {
    if (!_favorites.any((item) => item.date == model.date)) {
      _favorites.add(model);
      notifyListeners();
    }
  }

  void remove(APIModel model) {
    _favorites.removeWhere((item) => item.date == model.date);
    notifyListeners();
  }

  void clear() {
    _favorites.clear();
    notifyListeners();
  }
}
