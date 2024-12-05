import 'package:ammar_responsi/model/amiibo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  static const String favoriteKey = 'favorites';

  Future<void> saveFavorite(Amiibo amiibo) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList(favoriteKey) ?? [];
    favorites.add(json.encode({
      'name': amiibo.name,
      'image': amiibo.imageUrl,
      'gameSeries': amiibo.gameSeries,
      'head': amiibo.head
    }));
    prefs.setStringList(favoriteKey, favorites);
  }

  Future<List<Amiibo>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList(favoriteKey) ?? [];
    return favorites.map((item) => Amiibo.fromJson(json.decode(item))).toList();
  }

  Future<void> removeFavorite(String head) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList(favoriteKey) ?? [];
    favorites.removeWhere((item) => json.decode(item)['head'] == head);
    prefs.setStringList(favoriteKey, favorites);
  }
}
