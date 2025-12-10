# Movies App - Flutter Application

A Flutter application that displays popular movies with the ability to save favorites locally. Built with Clean Architecture principles.

## Features

- 🎬 Display list of popular movie posters on the home screen
- 📱 Navigate to detailed movie information screen
- ⭐ Save favorite movies to local database
- 🏗️ Clean Architecture with separation of concerns
- 🎨 Modern and beautiful UI

## Architecture

This project follows **Clean Architecture** principles with the following structure:

```
lib/
├── config/              # Configuration files (API keys, etc.)
├── data/               # Data layer
│   ├── models/         # Data models
│   ├── repositories/   # Repository implementations
│   └── services/       # API and Database services
├── domain/             # Domain layer
│   ├── entities/       # Business entities
│   └── repositories/   # Repository interfaces
└── presentation/       # Presentation layer
    ├── providers/      # State management (Provider)
    ├── screens/        # App screens
    └── widgets/        # Reusable widgets
```

## Setup Instructions

### 1. Get TMDB API Key

1. Visit [The Movie Database (TMDB)](https://www.themoviedb.org/)
2. Create a free account
3. Go to [API Settings](https://www.themoviedb.org/settings/api)
4. Request an API key
5. Copy your API key

### 2. Add API Key

Open `lib/config/api_config.dart` and replace `YOUR_API_KEY_HERE` with your actual API key:

```dart
static const String apiKey = 'YOUR_ACTUAL_API_KEY_HERE';
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the App

```bash
flutter run
```

## Dependencies

- **provider** - State management
- **http** - HTTP client for API calls
- **sqflite** - Local SQLite database
- **path_provider** - File system paths
- **cached_network_image** - Image caching
- **intl** - Date formatting

## Project Structure

### Data Layer
- `MovieApiService` - Fetches movies from TMDB API
- `DatabaseService` - Manages local SQLite database for favorites
- `MovieRepositoryImpl` - Implements repository interface

### Domain Layer
- `Movie` - Entity representing a movie
- `MovieRepository` - Repository interface

### Presentation Layer
- `MovieProvider` - Manages movie list state
- `MovieDetailsProvider` - Manages movie details state
- `HomeScreen` - Displays list of movies
- `MovieDetailsScreen` - Shows detailed movie information
- `MovieCard` - Reusable movie card widget

## Usage

1. **View Movies**: The home screen displays popular movies in a grid layout
2. **View Details**: Tap on any movie poster to see detailed information
3. **Add to Favorites**: Tap the heart icon on the details screen to save a movie
4. **Remove from Favorites**: Tap the heart icon again to remove from favorites

## API Configuration File

The API key is stored in:
```
lib/config/api_config.dart
```

**Important**: Replace `YOUR_API_KEY_HERE` with your actual TMDB API key before running the app.

## Platform Configuration

### Android
- Internet permission is configured in `android/app/src/main/AndroidManifest.xml`

### iOS
- Network security settings are configured in `ios/Runner/Info.plist`
- NSAppTransportSecurity allows HTTPS connections to TMDB API

## License

This project is open source and available for learning purposes.
