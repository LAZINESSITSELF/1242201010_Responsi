import 'dart:convert';
import 'package:ammar_responsi/model/amiibo_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://www.amiiboapi.com/api/amiibo';

  Future<List<Amiibo>> fetchAmiibos() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['amiibo'];
      return jsonResponse.map((amiibo) => Amiibo.fromJson(amiibo)).toList();
    } else {
      throw Exception('Failed to load amiibo data');
    }
  }
}
