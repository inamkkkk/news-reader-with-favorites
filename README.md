# News Reader with Favorites

A Flutter news reader application that allows users to browse news articles and save them as favorites for offline reading. The application uses local storage (SQLite) to persist the favorite articles.

## Features

*   Fetches news articles from a remote API.
*   Displays a list of news articles with titles, descriptions, and images.
*   Allows users to view the full article in a web view.
*   Allows users to save articles as favorites.
*   Persists favorite articles in local storage (SQLite).
*   Displays a list of favorite articles.
*   Responsive design for different screen sizes.

## Folder Structure


lib/
  main.dart
  screens/
    home_screen.dart
    article_detail_screen.dart
    favorites_screen.dart
  models/
    article_model.dart
  services/
    api_service.dart
    database_service.dart
  providers/
    news_provider.dart
    favorites_provider.dart


## State Management

This application uses Provider for state management.

## Database Integration

This application uses SQLite (sqflite package) for local storage.

## Getting Started

1.  Clone the repository.
2.  Run `flutter pub get` to install dependencies.
3.  Run `flutter run` to start the application.

## API Key

You will need to obtain an API key from a news API provider (e.g., NewsAPI). Update the `api_service.dart` file with your API key.
