import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_reader/models/article_model.dart';

class ApiService {
  final String apiKey = 'YOUR_API_KEY'; // Replace with your actual API key
  final String baseUrl = 'https://newsapi.org/v2/';

  Future<List<Article>> getArticles() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}top-headlines?country=us&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Article> articles = (data['articles'] as List)
            .map((articleJson) => Article.fromJson(articleJson))
            .toList();
        return articles;
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      print('Error fetching articles: $e');
      return [];
    }
  }
}
