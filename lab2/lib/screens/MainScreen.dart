import 'package:flutter/material.dart';
import 'package:lab2/models/Types.dart';
import 'package:lab2/screens/JokesScreen.dart';
import 'package:lab2/widgets/LoadingScreen.dart';
import 'package:lab2/widgets/appbar.dart';
import 'package:lab2/widgets/card.dart';

import '../services/api_services.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  final JokeService jokeService = JokeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Lab 2 by 196141"),
      body: FutureBuilder<List<Types>>(
        future: jokeService.fetchTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (snapshot.hasData) {
            final types = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 4 / 2,
              ),
              itemCount: types.length,
              itemBuilder: (context, index) {
                final type = types[index];
                return TypeCard(
                  type: type.type,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Jokescreen(type: type.type),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text("No data available."),
            );
          }
        },
      ),
    );
  }
}
