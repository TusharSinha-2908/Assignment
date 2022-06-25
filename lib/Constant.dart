import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPress;

  RoundedButton({Key? key, required this.text, required this.color, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 2,
      onPressed: onPress,
      height: MediaQuery.of(context).size.height * 0.05,
      color: color,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}



