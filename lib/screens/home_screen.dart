import 'package:flutter/material.dart';
import 'package:news_reader/models/article_model.dart';
import 'package:news_reader/providers/news_provider.dart';
import 'package:news_reader/screens/article_detail_screen.dart';
import 'package:news_reader/screens/favorites_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Reader'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (newsProvider.articles.isEmpty) {
            return Center(child: Text('No news available.'));
          } else {
            return ListView.builder(
              itemCount: newsProvider.articles.length,
              itemBuilder: (context, index) {
                Article article = newsProvider.articles[index];
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
