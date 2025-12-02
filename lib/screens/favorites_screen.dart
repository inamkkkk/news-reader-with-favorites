import 'package:flutter/material.dart';
import 'package:news_reader/models/article_model.dart';
import 'package:news_reader/providers/favorites_provider.dart';
import 'package:news_reader/screens/article_detail_screen.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          if (favoritesProvider.favorites.isEmpty) {
            return Center(child: Text('No favorites added.'));
          } else {
            return ListView.builder(
              itemCount: favoritesProvider.favorites.length,
              itemBuilder: (context, index) {
                Article article = favoritesProvider.favorites[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: article.urlToImage != null
                        ? Image.network(
                            article.urlToImage!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : null,
                    title: Text(article.title),
                    subtitle: Text(article.description ?? ''),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ArticleDetailScreen(article: article),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
