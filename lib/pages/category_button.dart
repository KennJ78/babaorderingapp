import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final String? icon;
  final bool isSelected;
  final VoidCallback? onPressed;

  const CategoryButton({
    super.key,
    required this.label,
    this.icon,
    this.isSelected = false,
    this.onPressed,
  });

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'Icons.all_inclusive':
        return Icons.all_inclusive;
      case 'Icons.build':
        return Icons.build;
      case 'Icons.power':
        return Icons.power;
      case 'Icons.lightbulb':
        return Icons.lightbulb;
      case 'Icons.electric_bolt':
        return Icons.electric_bolt;
      case 'Icons.cable':
        return Icons.cable;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: isSelected ? [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ] : null,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black87,
          backgroundColor: isSelected ? Colors.red[600] : Colors.grey[100],
          elevation: isSelected ? 4 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          minimumSize: const Size(0, 45),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                _getIconData(icon!),
                size: 18,
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 