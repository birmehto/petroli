import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:patroli/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  runApp(const Petroli());
}

class Petroli extends StatelessWidget {
  const Petroli({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Petrolin',
      debugShowCheckedModeBanner: false,
      home: Homepage(),
      theme: ThemeData(
        hintColor: Colors.green,
        primarySwatch: Colors.green,
        useMaterial3: false,
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
