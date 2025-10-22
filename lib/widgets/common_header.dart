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
    );
  }
}
