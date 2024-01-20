import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharmacie_api/models/pharmacie.dart';

class PharmacieService {
  final String baseUrl = 'http://localhost:3000/pharmacies';

  Future<List<Pharmacie>> chargerPharmacies() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> donnees = json.decode(response.body);
        return donnees.map((json) => Pharmacie.fromJson(json)).toList();
      } else {
        throw Exception('Échec du chargement des pharmacies');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite: $e');
    }
  }

  Future<Pharmacie> creerPharmacie(Pharmacie pharmacie) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pharmacie.toJson()),
      );

      if (response.statusCode == 201) {
        return Pharmacie.fromJson(json.decode(response.body));
      } else {
        throw Exception('Échec de la création de la pharmacie');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite: $e');
    }
  }

  Future<void> supprimerPharmacie(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 204) {
        throw Exception('Échec de la suppression de la pharmacie');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite: $e');
    }
  }
}
