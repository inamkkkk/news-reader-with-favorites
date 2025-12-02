class Article {
  final String title;
  final String? description;
  final String? urlToImage;
  final String url;

  Article({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'],
      urlToImage: json['urlToImage'],
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'url': url,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Article && runtimeType == other.runtimeType && url == other.url;

  @override
  int get hashCode => url.hashCode;
}
