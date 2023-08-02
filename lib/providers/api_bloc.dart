import 'package:flutter/material.dart';
import 'package:flutter_rickandmorty_app/domain/models/character_models.dart';
import 'package:flutter_rickandmorty_app/domain/models/episode_models.dart';
import 'package:flutter_rickandmorty_app/ui/screens/character/character_screen.dart';
import 'package:http/http.dart' as http;

class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com';
  List<Character> characters = [];
  List<Episode> episodes = [];

  Future<void> getCharacters(int page) async {
    final result = await http.get(
      Uri.https(url, '/api/character', {'page': page.toString()}),
    );
    final response = characterResponseFromJson(result.body);
    characters.addAll(response.results!);
    notifyListeners();
  }

  Future<List<Episode>> getEpisodes(Character character) async {
    for (var i = 0; i < character.episode!.length; i++) {
      final result = await http.get(Uri.parse(character.episode![i]));
      final response = episodeFromJson(result.body);
      episodes.add(response);
      notifyListeners();
    }

    return episodes;
  }
}
