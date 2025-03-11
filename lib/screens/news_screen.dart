// lib/screens/news_screen.dart
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("ข่าวสาร", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNewsCard("HR Asia Award", "assets/images/news1.jpg"),
          _buildNewsCard("Jetts Fitness Expansion", "assets/images/news2.jpg"),
          _buildNewsCard("New Yoga Programs", "assets/images/news3.jpg"),
        ],
      ),
    );
  }

  Widget _buildNewsCard(String title, String imagePath) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Image.asset(imagePath, height: 200, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}