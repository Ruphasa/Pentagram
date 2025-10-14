import 'package:flutter/material.dart';

class ProfileDropdown extends StatefulWidget {
  const ProfileDropdown({super.key});

  @override
  State<ProfileDropdown> createState() => _ProfileDropdownState();
}

class _ProfileDropdownState extends State<ProfileDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _showDropdown();
    } else {
      _hideDropdown();
    }
  }

  void _showDropdown() {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 240,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, -120), // jarak muncul di bawah avatar
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFF6C63FF),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: const Text("Admin Jawara",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text("admin1@gmail.com",
                        style: TextStyle(color: Colors.black54, fontSize: 12)),
                  ),
                  const Divider(height: 0),
                  InkWell(
                    onTap: () {
                      _hideDropdown();
                      _logout();
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                      child: Row(
                        children: [
                          Icon(Icons.logout, color: Colors.redAccent),
                          SizedBox(width: 10),
                          Text(
                            "Logout",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _hideDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _logout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logout berhasil!'),
        backgroundColor: Color.fromARGB(255, 85, 82, 255),
      ),
    );
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    _hideDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: _toggleDropdown,
        borderRadius: BorderRadius.circular(12),
        hoverColor: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFF6C63FF),
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Admin Jawara",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("admin1@gmail.com",
                        style: TextStyle(color: Colors.black54, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}
