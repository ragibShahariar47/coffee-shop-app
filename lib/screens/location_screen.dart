import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Screen'),
      ),
      body: const Center(
        child: Text('This is the Location Screen'),
      ),
    );
}}