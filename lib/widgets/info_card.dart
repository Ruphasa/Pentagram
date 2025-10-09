import 'package:flutter/material.dart';
import '../models/dashboard_item.dart';

class InfoCard extends StatelessWidget {
  final DashboardItem item;

  const InfoCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(item.icon, color: Colors.black54, size: 20),
              const SizedBox(width: 8),
              Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Tampilkan konten dari model
          item.content,
        ],
      ),
    );
  }
}