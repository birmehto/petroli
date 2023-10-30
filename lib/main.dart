import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const Petroli());
}

class Petroli extends StatelessWidget {
  const Petroli({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Center(
            child: Text(
              'Petroli',
              style: TextStyle(color: Colors.greenAccent, fontFamily: 'Oswald'),
            ),
          ),
        ),
        body: const Column(children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'plese enter a value',
            ),
          )
        ]),
      ),
    );
  }
}
