import 'package:flutter/material.dart';

class TypeCard extends StatelessWidget {
  final String type;
  final VoidCallback onTap;

  const TypeCard({
    super.key,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onTap,
        title: Padding(
          padding: const EdgeInsets.all(8.0), // Controls spacing inside the card
          child: Center(
            child: Text(
              type,
              style: const TextStyle(fontSize: 14), // Adjust font size as needed
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
