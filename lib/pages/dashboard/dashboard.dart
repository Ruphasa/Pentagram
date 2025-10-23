import 'package:flutter/material.dart';
import 'package:pentagram/models/activity.dart';
import 'package:pentagram/models/activity_log.dart';
import 'package:pentagram/services/activity_service.dart';
import 'package:pentagram/services/activity_log_service.dart';
import 'package:pentagram/widgets/dashboard/dashboard_app_bar.dart';
import 'package:pentagram/widgets/dashboard/upcoming_events_section.dart';
import 'package:pentagram/widgets/dashboard/quick_access_section.dart';
import 'package:pentagram/widgets/dashboard/statistics_section.dart';
import 'package:pentagram/widgets/dashboard/activity_log_section.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ActivityService _activityService = ActivityService();
  final ActivityLogService _activityLogService = ActivityLogService();

  late List<Activity> _upcomingActivities;
  late List<ActivityLog> _recentLogs;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// Load all data from services
  void _loadData() {
    setState(() {
      _upcomingActivities = _activityService.getUpcomingActivities();
      _recentLogs = _activityLogService.getRecentActivityLogs(limit: 3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DashboardAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            UpcomingEventsSection(activities: _upcomingActivities),
            const SizedBox(height: 24),
            const QuickAccessSection(),
            const SizedBox(height: 24),
            const StatisticsSection(),
            const SizedBox(height: 24),
            ActivityLogSection(recentLogs: _recentLogs),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
