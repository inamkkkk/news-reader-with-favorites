import 'package:flutter/material.dart';
import 'package:news_reader/models/article_model.dart';
import 'package:news_reader/providers/favorites_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  ArticleDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              bool isFavorite = favoritesProvider.isFavorite(article);
              return IconButton(
                icon:
                    Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  if (isFavorite) {
                    favoritesProvider.removeFavorite(article);
                  } else {
                    favoritesProvider.addFavorite(article);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: WebView( 
        initialUrl: article.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
