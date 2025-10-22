import 'package:pentagram/models/activity.dart';
import 'package:pentagram/repositories/activity_repository.dart';

/// Service for Activity business logic
/// This layer handles business rules and orchestrates data operations
class ActivityService {
  // Singleton pattern
  static final ActivityService _instance = ActivityService._internal();
  factory ActivityService() => _instance;
  ActivityService._internal();

  final ActivityRepository _repository = ActivityRepository();

  /// Get all activities
  List<Activity> getAllActivities() {
    return _repository.findAll();
  }

  /// Get upcoming activities (today and future)
  List<Activity> getUpcomingActivities() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    return _repository.findAll().where((activity) {
      final activityDate = DateTime(
        activity.tanggal.year,
        activity.tanggal.month,
        activity.tanggal.day,
      );
      return activityDate.isAtSameMomentAs(today) || 
             activityDate.isAfter(today);
    }).toList()
      ..sort((a, b) => a.tanggal.compareTo(b.tanggal));
  }

  /// Get past activities (completed)
  List<Activity> getPastActivities() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    return _repository.findAll().where((activity) {
      final activityDate = DateTime(
        activity.tanggal.year,
        activity.tanggal.month,
        activity.tanggal.day,
      );
      return activityDate.isBefore(today);
    }).toList()
      ..sort((a, b) => b.tanggal.compareTo(a.tanggal));
  }

  /// Get today's activities
  List<Activity> getTodayActivities() {
    final now = DateTime.now();
    return _repository.findAll().where((activity) {
      return activity.tanggal.year == now.year &&
          activity.tanggal.month == now.month &&
          activity.tanggal.day == now.day;
    }).toList()
      ..sort((a, b) => a.tanggal.compareTo(b.tanggal));
  }

  /// Get activities by category
  List<Activity> getActivitiesByCategory(String category) {
    return _repository.findByCategory(category);
  }

  /// Get activity by ID
  Activity? getActivityById(int id) {
    return _repository.findById(id);
  }

  /// Get activities for current month
  List<Activity> getCurrentMonthActivities() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
    
    return _repository.findByDateRange(startOfMonth, endOfMonth);
  }

  /// Get completion statistics for current month
  Map<String, dynamic> getMonthlyStatistics() {
    final monthActivities = getCurrentMonthActivities();
    final pastActivities = getPastActivities();
    
    final completedThisMonth = monthActivities.where((activity) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final activityDate = DateTime(
        activity.tanggal.year,
        activity.tanggal.month,
        activity.tanggal.day,
      );
      return activityDate.isBefore(today);
    }).length;

    final totalThisMonth = monthActivities.length;
    final percentage = totalThisMonth > 0 
        ? (completedThisMonth / totalThisMonth * 100).round() 
        : 0;

    return {
      'total': totalThisMonth,
      'completed': completedThisMonth,
      'percentage': percentage,
      'remaining': totalThisMonth - completedThisMonth,
    };
  }

  /// Add new activity
  Activity addActivity(Activity activity) {
    return _repository.create(activity);
  }

  /// Update existing activity
  bool updateActivity(Activity activity) {
    return _repository.update(activity) != null;
  }

  /// Delete activity
  bool deleteActivity(int id) {
    return _repository.delete(id);
  }

  /// Check if activity can be edited (business rule)
  bool canEditActivity(Activity activity) {
    // Example business rule: Can only edit future activities
    final now = DateTime.now();
    return activity.tanggal.isAfter(now);
  }

  /// Check if activity can be deleted (business rule)
  bool canDeleteActivity(Activity activity) {
    // Example business rule: Can delete any activity
    return true;
  }

  /// Get total activities count
  int getTotalActivitiesCount() {
    return _repository.count();
  }

  /// Search activities by name
  List<Activity> searchActivities(String query) {
    if (query.trim().isEmpty) {
      return getAllActivities();
    }

    final lowercaseQuery = query.toLowerCase();
    return _repository.findAll().where((activity) {
      return activity.nama.toLowerCase().contains(lowercaseQuery) ||
          activity.kategori.toLowerCase().contains(lowercaseQuery) ||
          activity.penanggungJawab.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  /// Get activities by responsible person
  List<Activity> getActivitiesByPenanggungJawab(String penanggungJawab) {
    return _repository.findAll()
        .where((activity) => activity.penanggungJawab == penanggungJawab)
        .toList();
  }

  /// Get popular categories (most used)
  List<Map<String, dynamic>> getPopularCategories() {
    final activities = _repository.findAll();
    final categoryCount = <String, int>{};

    for (var activity in activities) {
      categoryCount[activity.kategori] = 
          (categoryCount[activity.kategori] ?? 0) + 1;
    }

    final sorted = categoryCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sorted.map((entry) {
      return {
        'kategori': entry.key,
        'count': entry.value,
      };
    }).toList();
  }
}