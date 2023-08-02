import 'package:flutter/material.dart';
import 'package:flutter_rickandmorty_app/domain/models/character_models.dart';
import 'package:flutter_rickandmorty_app/providers/api_bloc.dart';
import 'package:flutter_rickandmorty_app/ui/screens/character/character_screen.dart';
import 'package:flutter_rickandmorty_app/ui/screens/home/home.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _route = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'character',
          builder: (context, state) {
            final character = state.extra as Character;
            return CharacterScreen(
              character: character,
            );
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiProvider(),
      child: MaterialApp.router(
        title: 'App RickAndMorty',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        routerConfig: _route,
      ),
    );
  }
}
