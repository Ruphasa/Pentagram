import 'package:flutter/material.dart';
import 'package:pentagram/models/side_menu_items.dart';
import 'package:pentagram/routes/routes.dart';
import 'package:pentagram/utils/icon_mapper.dart';

// Shared dark palette
const _kBlack = Color(0xFF0B0B0F);
const _kText = Colors.white;
const _kTextMuted = Colors.white70;
const _kPurple = Color(0xFFB565F6);

class SideMenuPage extends StatefulWidget {
  const SideMenuPage({super.key});

  @override
  State<SideMenuPage> createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: _kBlack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SideMenuHeader(),
            const _MenuLabel(),
            // Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  // Top single items
                  ...sideMenuTopItems.map((item) {
                    final route = item['route'] as String?;
                    final isSelected = route != null && _isCurrentRoute(context, route);
                    return _MenuTile(
                      title: item['title'] as String,
                      icon: iconFromKey(item['iconKey'] as String),
                      isSelected: isSelected,
                      onTap: () {
                        final builder = builderFromAction(item['action'] as String?);
                        if (builder != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: builder,
                              settings: RouteSettings(name: route),
                            ),
                          );
                        }
                      },
                    );
                  }),
                  // Sections
                  ...sideMenuSections.map((section) {
                    final String title = section['title'] as String;
                    final String iconKey = section['iconKey'] as String;
                    final bool initiallyExpanded = (section['initiallyExpanded'] as bool?) ?? false;
                    final List<dynamic> items = (section['items'] as List<dynamic>? ?? []);
                    return Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: initiallyExpanded,
                        leading: Icon(iconFromKey(iconKey), color: _kTextMuted),
                        title: Text(title, style: const TextStyle(color: _kText, fontWeight: FontWeight.w500)),
                        children: items.map<Widget>((e) {
                          final map = e as Map<String, dynamic>;
                          // Nested children (e.g., Mutasi Keluarga)
                          if (map.containsKey('children')) {
                            final List<dynamic> sub = map['children'] as List<dynamic>;
                            return Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                leading: Icon(iconFromKey(map['iconKey'] as String), color: _kTextMuted),
                                title: Text(map['title'] as String, style: const TextStyle(color: _kText)),
                                children: sub.map<Widget>((s) {
                                  final sm = s as Map<String, dynamic>;
                                  final subRoute = sm['route'] as String?;
                                  final isSubSelected = subRoute != null && _isCurrentRoute(context, subRoute);
                                  return _DrawerListTile(
                                    title: sm['title'] as String,
                                    icon: iconFromKey(sm['iconKey'] as String),
                                    isSubMenu: true,
                                    isSelected: isSubSelected,
                                    onTap: () {
                                      final b = builderFromAction(sm['action'] as String?);
                                      if (b != null) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: b,
                                            settings: RouteSettings(name: subRoute),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                }).toList(),
                              ),
                            );
                          }
                          // Leaf items
                          final leafRoute = map['route'] as String?;
                          final isLeafSelected = leafRoute != null && _isCurrentRoute(context, leafRoute);
                          return _DrawerListTile(
                            title: map['title'] as String,
                            icon: iconFromKey(map['iconKey'] as String),
                            isSubMenu: true,
                            isSelected: isLeafSelected,
                            onTap: () {
                              final b = builderFromAction(map['action'] as String?);
                              if (b != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: b,
                                    settings: RouteSettings(name: leafRoute),
                                  ),
                                );
                              }
                            },
                          );
                        }).toList(),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const Divider(color: Colors.white12, height: 1),
            // Logout Button
            const _LogoutButton(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Helper method to check if a route is currently active
  bool _isCurrentRoute(BuildContext context, String route) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return currentRoute == route;
  }
}

// Extracted static header widget
class _SideMenuHeader extends StatelessWidget {
  const _SideMenuHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: _kPurple,
            child: Text(
              'A',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Admin',
                  style: TextStyle(
                    color: _kText,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Administrator',
                  style: TextStyle(
                    color: _kTextMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Static menu label widget
class _MenuLabel extends StatelessWidget {
  const _MenuLabel();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        'Menu Utama',
        style: TextStyle(
          color: _kTextMuted,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Static logout button widget
class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: const Icon(Icons.logout, color: _kTextMuted, size: 20),
      title: const Text(
        'Logout',
        style: TextStyle(color: _kText, fontSize: 14),
      ),
      onTap: () {
        // Handle logout
      },
    );
  }
}

// Clean menu tile with purple rounded active state
class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isSelected = false,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isSelected ? _kPurple : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : _kTextMuted,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : _kText,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

// Helper widget for submenu items
class _DrawerListTile extends StatelessWidget {
  const _DrawerListTile({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isSubMenu = false,
    this.isSelected = false,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSubMenu;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: isSelected ? _kPurple : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListTile(
        contentPadding: isSubMenu
            ? const EdgeInsets.only(left: 48.0, right: 16)
            : const EdgeInsets.symmetric(horizontal: 16),
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : _kTextMuted,
          size: 18,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : _kText,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
