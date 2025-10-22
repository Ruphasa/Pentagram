import 'package:flutter/material.dart';
import 'package:pentagram/utils/app_colors.dart';

class CommonHeader extends StatelessWidget {
  final String title;
  final Widget? subtitle;
  final List<Widget>? actions;
  final double expandedHeight;

  const CommonHeader({
    required this.title, super.key,
    this.subtitle,
    this.actions,
    this.expandedHeight = 120,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: false,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        title: Padding(
          padding: const EdgeInsetsDirectional.only(start: 24, bottom: 16),
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
          child: subtitle != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(16, 70, 16, 16),
                  child: subtitle!,
                )
              : null,
        ),
      ),
      actions: [
        // Profile avatar button
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () {
              // Navigate to profile page or show dropdown
              _showProfileMenu(context);
            },
            child: const CircleAvatar(
              backgroundColor: AppColors.textOnPrimary,
              radius: 18,
              child: Icon(
                Icons.person,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ),
        ),
        // Additional actions if provided
        ...?actions,
      ],
    );
  }

  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Icon(Icons.person, color: AppColors.textOnPrimary),
              ),
              title: Text(
                'Admin Jawara',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              subtitle: Text(
                'admin1@gmail.com',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person_outline, color: AppColors.primary),
              title: const Text('Lihat Profil'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to profile page
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: AppColors.primary),
              title: const Text('Edit Profil'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to edit profile page
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: const Text(
                'Logout',
                style: TextStyle(color: AppColors.error),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
