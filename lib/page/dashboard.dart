import 'package:flutter/material.dart';
import 'package:pentagram/responsive.dart';
import 'package:pentagram/widgets/dashboard_grid.dart';
import 'package:pentagram/widgets/side_menu.dart';

class DashboardScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),
            
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!Responsive.isDesktop(context))
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                      ),
                    const SizedBox(height: 18.0),

                    const DashboardGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}