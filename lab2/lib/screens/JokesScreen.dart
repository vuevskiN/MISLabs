import 'package:flutter/material.dart';
import 'package:lab2/screens/RandomJokesScreen.dart';
import 'package:lab2/widgets/LoadingScreen.dart';
import '../services/api_services.dart';
import '../models/Type.dart';
import '../widgets/AppBarButton.dart';

class Jokescreen extends StatelessWidget {
  final String type;

   Jokescreen({super.key, required this.type});

  final JokeService jokeService = JokeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithButton(
        buttonText: "Click to get Random Joke",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Randomjokesscreen(),
            ),
          );
        },
      ),
      body: FutureBuilder<List<Type>>(
        future: jokeService.fetchJokes(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return const Center(child: Text("No joke found"));
          } else {
            final jokes = snapshot.data!;
            return GridView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                );
              }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 4/2,),
            );
          }
        },
      ),
    );
  }
}
