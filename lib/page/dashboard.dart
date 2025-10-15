import 'package:flutter/material.dart';
import 'package:pentagram/widgets/dashboard_grid.dart';
import 'package:pentagram/widgets/side_menu.dart';
import 'package:pentagram/widgets/app_header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,),
      drawer: const SideMenu(),
      body: const SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [SizedBox(height: 18.0), DashboardGrid()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
