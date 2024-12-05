import 'package:ammar_responsi/model/amiibo_model.dart';
import 'package:flutter/material.dart';

class AmiiboCard extends StatelessWidget {
  final Amiibo amiibo;
  final VoidCallback onTap;

  const AmiiboCard({super.key, required this.amiibo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: ListTile(
        leading: SizedBox(
          width: 60,
          height: 60,
          child: Image.network(
            amiibo.imageUrl.isNotEmpty ? amiibo.imageUrl : 'https://example.com/default_image.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.image_not_supported, size: 40);
            },
          ),
        ),
        title: Text(
          amiibo.name.isNotEmpty ? amiibo.name : 'Unknown Amiibo',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          amiibo.gameSeries.isNotEmpty ? amiibo.gameSeries : 'Unknown Game Series',
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
