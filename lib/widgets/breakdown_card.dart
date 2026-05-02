import 'package:flutter/material.dart';

class BreakdownCard extends StatelessWidget {
  final String title;
  final double persentage;
  final IconData icon;
  final Color color;

  const BreakdownCard({
    super.key,
    required this.title,
    required this.persentage,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(240, 244, 249, 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const Spacer(),

          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(67, 71, 76, 1),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "${(persentage * 100).toStringAsFixed(0)}%",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF171C20),
            ),
          ),

          const SizedBox(height: 8),

          LinearProgressIndicator(
            value: persentage,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}
