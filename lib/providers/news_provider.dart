import 'package:flutter/material.dart';
import 'package:news_reader/models/article_model.dart';
import 'package:news_reader/services/api_service.dart';

class NewsProvider extends ChangeNotifier {
  List<Article> _articles = [];
  bool _isLoading = false;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;

  Future<void> fetchArticles() async {
    _isLoading = true;
    notifyListeners();

    try {
      final articles = await ApiService().getArticles();
      _articles = articles;
    } catch (e) {
      print('Error fetching articles: $e');
      _articles = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
