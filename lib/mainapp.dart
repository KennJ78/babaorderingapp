import 'package:flutter/material.dart';

void main() {
  runApp(const RamenApp());
}

class RamenApp extends StatelessWidget {
  const RamenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BABA App',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.grey[900],
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                hintText: 'Search menu items...',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Category buttons
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                CategoryButton(label: 'All', isSelected: true),
                CategoryButton(label: 'Tools'),
                CategoryButton(label: 'Switches'),
                CategoryButton(label: 'Lighting'),
                CategoryButton(label: 'Circuit Breaker'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryButton({
    super.key,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.black,
        backgroundColor: isSelected ? Colors.red[600] : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: () {},
      child: Text(label),
    );
  }
}
