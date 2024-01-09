import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:poc1/model/breed.dart';

class Connection {
  static const _path = 'https://dog.ceo/api';


  /// Scarica la lista delle razze e sottorazze
  Future<List<Breed>?> getAllBreeds() async {
    const apiUrl = '$_path/breeds/list/all';

    final client = Client();

    final response = await client.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      // Fa un check sullo status
      if (data['status'] == 'success') {
        final breed = (data['message'] as Map<String, dynamic>);
        final breedStored = <Breed>[];
        for (var element in breed.entries) {
          // imposto la prima lettera maiuscola essendo nomi propri di razze
          final key = element.key[0].toUpperCase() + element.key.substring(1);
          final elementSubBreed =
              (element.value as List).map((e) => e as String).toList();
          breedStored.add(Breed(name: key, subBreeds: elementSubBreed));
        }
        return breedStored;
      } else {
        // nel caso lo status non sia 'success'
        debugPrint('API request failed. Status: ${data['status']}');
        return null;
      }
    } else {
      debugPrint('Failed to load data. Status code: ${response.statusCode}');
      return null;
    }
  }

  /// Parsifica la response per scaricare le immagini
  List<String>? _parseResponse(Response response) {
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['status'] == 'success') {
        return List<String>.from(data['message']);
      }
    }
    return null;
  }

  /// Genera immagini per razza
  /// Se definedNum è definito ne genera una lista, solo una altrimenti
  Future<List<String>?> getRandomImageByBreed({
    required Breed breed,
    int? definedNum,
  }) async {
    final apiUrl =
        '$_path/breed/${breed.name.toLowerCase()}/images/random/$definedNum';
    debugPrint('use -> $apiUrl');
    final client = Client();
    final response = await client.get(Uri.parse(apiUrl));

    return _parseResponse(response);
  }



  /// Genera immagini per sottorazza
  /// Se definedNum è definito ne genera una lista, solo una altrimenti
  Future<List<String>?> getRandomImageBySubbreed({
    required String breed,
    required String subreed,
    int? definedNum,
  }) async {
    final apiUrl =
        '$_path/breed/${breed.toLowerCase()}/${subreed.toLowerCase()}/images/random/$definedNum';
    debugPrint('use -> $apiUrl');
    final client = Client();
    final response = await client.get(Uri.parse(apiUrl));

    return _parseResponse(response);
  }
}
