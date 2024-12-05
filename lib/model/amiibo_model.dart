class Amiibo {
  final String amiiboSeries;
  final String character;
  final String gameSeries;
  final String head;
  final String imageUrl;
  final String name;
  final String type;
  final Map<String, String> release;

  Amiibo({
    required this.amiiboSeries,
    required this.character,
    required this.gameSeries,
    required this.head,
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.release,
  });

  factory Amiibo.fromJson(Map<String, dynamic> json) {
    return Amiibo(
      amiiboSeries: json['amiiboSeries'] ?? 'Unknown Series',
      character: json['character'] ?? 'Unknown Character',
      gameSeries: json['gameSeries'] ?? 'Unknown Game Series',
      head: json['head'] ?? '',
      imageUrl: json['image'] ?? '',
      name: json['name'] ?? 'Unknown Name',
      type: json['type'] ?? 'Unknown Type',
      release: json['release'] != null
          ? (json['release'] as Map<String, dynamic>)
              .map<String, String>((key, value) {
              return MapEntry(key,
                  value?.toString() ?? 'N/A'); // Penanganan null dan konversi
            })
          : {},
    );
  }
}
