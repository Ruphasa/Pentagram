import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
    this.isSubMenu = false,
    this.iconColor,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSubMenu;
  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final Color ic = iconColor ?? Colors.white70;
    final Color tx = textColor ?? Colors.white;
    return ListTile(
      contentPadding: isSubMenu
          ? const EdgeInsets.only(left: 48.0)
          : const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon, color: ic),
      title: Text(title, style: TextStyle(color: tx)),
      onTap: onTap,
    );
  }
}
