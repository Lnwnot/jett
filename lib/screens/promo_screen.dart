// lib/screens/promo_screen.dart
import 'package:flutter/material.dart';

class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("โปรโมชั่น", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPromoCard("March 2025 Discount", "assets/images/promo1.jpg"),
          _buildPromoCard("Get Fit for Less", "assets/images/promo2.jpg"),
          _buildPromoCard("Limited Time Offer!", "assets/images/promo3.jpg"),
        ],
      ),
    );
  }

  Widget _buildPromoCard(String title, String imagePath) {
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