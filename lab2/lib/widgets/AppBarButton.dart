import 'package:flutter/material.dart';

class CustomAppBarWithButton extends StatelessWidget implements PreferredSizeWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomAppBarWithButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ElevatedButton(
        onPressed: onPressed,
        child: Text(buttonText),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
