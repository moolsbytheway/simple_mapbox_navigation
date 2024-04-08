import 'package:flutter/material.dart';

import 'package:mapbox_navigation/mapbox_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final mapBoxNavigation = MapboxNavigation();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Mapbox navigation launcher')),
            body: Center(
                child: ElevatedButton(
                          onPressed: _openMap,
                          child: const Text("Open map"),
                        ))));
  }

  void _openMap() {
    mapBoxNavigation.startActivity();
  }
}
