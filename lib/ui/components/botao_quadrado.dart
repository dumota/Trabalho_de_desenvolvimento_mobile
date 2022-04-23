import 'package:flutter/material.dart';

class BotaoQuadrado extends StatelessWidget {

  final String texto;
  final VoidCallback clique;

  const BotaoQuadrado({ Key? key, required this.texto, required this.clique }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ElevatedButton(
        onPressed:  clique,
        child: Text(texto),
      ),
    );
  }
}