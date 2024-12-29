import 'package:flutter/material.dart';
import '../models/Type.dart';

class FavoriteJokesScreen extends StatelessWidget {
  final List<Type> favoriteJokes;

  const FavoriteJokesScreen({Key? key, required this.favoriteJokes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Jokes"),
      ),
      body: favoriteJokes.isEmpty
          ? const Center(child: Text("No favorites added yet!"))
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          final joke = favoriteJokes[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    joke.setup,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(joke.punchline, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
