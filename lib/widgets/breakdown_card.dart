import 'package:flutter/material.dart';

class BreakdownCard extends StatelessWidget {
  final String title;
  final String persentage;
  final double progress;
  final IconData icon;
  final Colors color;

  const BreakdownCard({
    super.key,
    required this.title,
    required this.persentage,
    required this.progress,
    required this.icon,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}