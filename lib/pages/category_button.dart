import 'package:flutter/material.dart';

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
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: () {},
      child: Text(label),
    );
  }
} 