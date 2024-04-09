import 'package:flutter/material.dart';

import 'package:simple_mapbox_navigation/simple_mapbox_navigation.dart';

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
                child: Column(children: [
              const Text("From: 33.605917, -7.520119"),
              const Text("To: 33.607320, -7.516551"),
              ElevatedButton(
                onPressed: _openMap,
                child: const Text("Open map"),
              )
            ]))));
  }

  void _openMap() {
    mapBoxNavigation.startNavigation(
        33.605917, -7.520119, 33.607320, -7.516551);
  }
}
