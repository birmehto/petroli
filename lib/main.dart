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
      home: const Homepage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: false,
      ),
    );
  }
}
