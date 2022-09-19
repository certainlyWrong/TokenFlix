import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:tokenflix/view/home/home.view.dart';
import 'package:tokenflix/controller/movie.controller.dart';
import 'package:tokenflix/controller/movie_informations.controller.dart';

void main() {
  // if (kDebugMode) {
  //   debugRepaintRainbowEnabled = true;
  // }

  runApp(const TokenFlixApp());
}

class TokenFlixApp extends StatelessWidget {
  const TokenFlixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<MovieController>(
            create: (_) => MovieController.create(),
          ),
          Provider<MovieInformationsController>(
            create: (context) => MovieInformationsController.create(),
          ),
        ],
        child: MaterialApp(
          title: 'TokenFlix',
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.purple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.purple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: Brightness.dark,
          ),
          themeMode: ThemeMode.light,
          home: const HomeView(),
        ));
  }
}
