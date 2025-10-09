import 'package:flutter/material.dart';

// Model untuk merepresentasikan data setiap kartu di dashboard
class DashboardItem {
  final String title;
  final IconData icon;
  final Color color;
  final Widget content; // Konten bisa berupa widget apa saja
  final double width;    // Lebar kartu untuk layout desktop

  DashboardItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.content,
    this.width = 350, // Lebar default
  });
}