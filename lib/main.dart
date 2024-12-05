import 'package:ammar_responsi/screens/favorite.dart';
import 'package:ammar_responsi/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AmiiboApp());
}

class AmiiboApp extends StatefulWidget {
  const AmiiboApp({super.key});

  @override
  State<AmiiboApp> createState() => _AmiiboAppState();
}

class _AmiiboAppState extends State<AmiiboApp> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [HomeScreen(), FavoriteScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nintendo Amiibo App',
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
          ],
        ),
      ),
    );
  }
}
