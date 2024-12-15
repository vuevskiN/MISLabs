import 'package:flutter/material.dart';
import 'package:lab2/widgets/LoadingScreen.dart';
import 'package:lab2/widgets/appbar.dart';
import '../models/Random.dart';
import '../services/api_services.dart';

class Randomjokesscreen extends StatelessWidget {
   Randomjokesscreen({super.key});

  final JokeService jokeService = JokeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Lab 2 by 196141"),
      body: FutureBuilder<Random>(
        future: jokeService.fetchRandom(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();

          } else if (snapshot.hasError) {
            return const Center(child: Text("No joke found"));
          } else if (snapshot.hasData) {
            final joke = snapshot.data!;
            return ListTile(
              title: Text(joke.setup),
              subtitle: Text(joke.punchline),
            );
          } else {
            return const Center(child: Text("No joke found"));
          }
        },
      ),
    );
  }
}
