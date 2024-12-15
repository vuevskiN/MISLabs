import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Type.dart';
import '../models/Types.dart';
import '../models/Random.dart';


class JokeService{
  Future<List<Type>> fetchJokes(String type) async {
    final url = 'https://official-joke-api.appspot.com/jokes/$type/ten';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = response.body;
      final List<dynamic> data = jsonDecode(body);
      return data.map((json) => Type.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load jokes');
    }
  }

  Future<List<Types>> fetchTypes() async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/types'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((type) => Types.fromJson(type)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<Random> fetchRandom() async {
    final url = 'https://official-joke-api.appspot.com/random_joke';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = response.body;
      final data = jsonDecode(body);
      return Random.fromJson(data);
    } else {
      throw Exception('Failed to load joke');
    }
  }
}