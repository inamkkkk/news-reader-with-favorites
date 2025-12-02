import 'package:flutter/foundation.dart';
import 'package:news_reader/models/article_model.dart';
import 'package:news_reader/services/database_service.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Article> _favorites = [];
  final DatabaseService _databaseService = DatabaseService();

  List<Article> get favorites => _favorites;

  FavoritesProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    _favorites = await _databaseService.getFavorites();
    notifyListeners();
  }

  Future<void> addFavorite(Article article) async {
    _favorites.add(article);
    await _databaseService.insertFavorite(article);
    notifyListeners();
  }

  Future<void> removeFavorite(Article article) async {
    _favorites.remove(article);
    _favorites.removeWhere((element) => element.title == article.title);
    await _databaseService.deleteFavorite(article.title);
    loadFavorites();
    notifyListeners();
  }

  bool isFavorite(Article article) {
    return _favorites.contains(article);
  }
}
