import 'package:ammar_responsi/model/amiibo_model.dart';
import 'package:ammar_responsi/screens/detail.dart';
import 'package:ammar_responsi/services/base_network.dart';
import 'package:ammar_responsi/widgets/amiibo_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Amiibo>> futureAmiibo;

  @override
  void initState() {
    super.initState();
    futureAmiibo = apiService.fetchAmiibos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Amiibo List')),
      body: FutureBuilder<List<Amiibo>>(
        future: futureAmiibo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final amiibos = snapshot.data!;
            return ListView.builder(
              itemCount: amiibos.length,
              itemBuilder: (context, index) {
                return AmiiboCard(
                  amiibo: amiibos[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(amiibo: amiibos[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
