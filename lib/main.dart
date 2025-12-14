import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/data/repositories/movie_repository_impl.dart';
import 'package:movies_app/data/services/database_service.dart';
import 'package:movies_app/data/services/movie_api_service.dart';
import 'package:movies_app/domain/repositories/movie_repository.dart';
import 'package:movies_app/presentation/providers/movie_details_provider.dart';
import 'package:movies_app/presentation/providers/movie_provider.dart';
import 'package:movies_app/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    // Initialize services
    final movieApiService = MovieApiService();
    final databaseService = DatabaseService.instance;
    final MovieRepository movieRepository = MovieRepositoryImpl(
      apiService: movieApiService,

      databaseService: databaseService,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieProvider(movieRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => MovieDetailsProvider(movieRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Movies App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
