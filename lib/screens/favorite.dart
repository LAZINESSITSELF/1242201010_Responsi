import 'package:ammar_responsi/model/amiibo_model.dart';
import 'package:ammar_responsi/screens/detail.dart';
import 'package:flutter/material.dart';
import '../utils/local_storage.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final LocalStorage localStorage = LocalStorage();
  List<Amiibo> favoriteAmiibos = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    final favorites = await localStorage.getFavorites();
    setState(() {
      favoriteAmiibos = favorites;
    });
  }

  void _removeFavorite(String head) async {
    await localStorage.removeFavorite(head);
    _loadFavorites();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Removed from favorites')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favoriteAmiibos.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              itemCount: favoriteAmiibos.length,
              itemBuilder: (context, index) {
                final amiibo = favoriteAmiibos[index];
                return Dismissible(
                  key: Key(amiibo.head),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _removeFavorite(amiibo.head);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: Image.network(amiibo.imageUrl),
                    title: Text(amiibo.name),
                    subtitle: Text(amiibo.gameSeries),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(amiibo: amiibo),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
