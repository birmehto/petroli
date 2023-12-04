import 'package:flutter/material.dart';

import 'package:patroli/home.dart';

void main() {
  runApp(const Petroli());
}

class Petroli extends StatelessWidget {
  const Petroli({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
      theme: ThemeData(
        // primaryColor: Color.fromRGBO(253, 147, 70, 1),
        primarySwatch: Colors.purple,

        useMaterial3: false,
      ),
    );
  }
}
