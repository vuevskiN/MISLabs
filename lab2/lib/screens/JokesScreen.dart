import 'package:flutter/material.dart';
import 'package:lab2/screens/FavoriteJokesScreen.dart';
import 'package:lab2/screens/RandomJokesScreen.dart';
import '../services/api_services.dart';
import '../models/Type.dart';
import '../widgets/LoadingScreen.dart';

class Jokescreen extends StatefulWidget {
  final String type;

  Jokescreen({super.key, required this.type});

  @override
  _JokescreenState createState() => _JokescreenState();
}

class _JokescreenState extends State<Jokescreen> {
  final JokeService jokeService = JokeService();
  final List<Type> favoriteJokes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Click to get a random joke -->"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle), // Icon for random jokes
            onPressed: () {
              // Navigate to the Random Jokes Screen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Randomjokesscreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Navigate to the Favorite Jokes Screen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      FavoriteJokesScreen(favoriteJokes: favoriteJokes),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Type>>(
        future: jokeService.fetchJokes(widget.type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return const Center(child: Text("No joke found"));
          } else {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  trailing: IconButton(
                    icon: Icon(
                      favoriteJokes.contains(joke)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteJokes.contains(joke)
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        if (!favoriteJokes.contains(joke)) {
                          favoriteJokes.add(joke);
                        } else {
                          favoriteJokes.remove(joke);
                        }
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
