import 'package:firebase_database/firebase_database.dart';
import 'package:jiffy/jiffy.dart';
import 'package:plastic_tracker/api_client/model/category.dart';
import 'package:plastic_tracker/user/app_user.dart';
import 'package:week_of_year/week_of_year.dart';

import 'model/usage.dart';

class APIClient {
  DatabaseReference _databaseReference;
  AppUser user;
  final String dailyUsage = "dailyUserConsumption";
  final String weeklyUsage = "weeklyUserConsumption";
  final String monthlyUsage = "monthlyUserConsumption";

  APIClient.withDatabaseReference(DatabaseReference databaseReference) {
    this._databaseReference = databaseReference;
  }

  APIClient(AppUser user) {
    this.user = user;
    if (_databaseReference == null) {
      _databaseReference = FirebaseDatabase.instance.reference();
    }
  }

  Future<List<Category>> getCategories() async {
    var result = await _databaseReference.child("categories").once();
    return Category.fromJsonList(result.value);
  }

  addUsage(Usage usage) async {
    DateTime dateTime = DateTime.now();
    await _updateUsage(dailyUsage, _getDailyUsageKey(dateTime), usage);
    await _updateUsage(weeklyUsage, _getWeeklyUsageKey(dateTime), usage);
    await _updateUsage(monthlyUsage, _getMonthlyUsageKey(dateTime), usage);
  }

  Future<Map<String, List<Usage>>> getDailyUsages() async {
    Map<String, List<Usage>> result = Map();
    DateTime dateTime = DateTime.now();
    for (var i = 0; i < 7; i++) {
      var key = _getDailyUsageKey(dateTime);
      List<Usage> data = await _getUsage(dailyUsage, key);
      result[key] = data;
      dateTime = Jiffy(dateTime).subtract(days: 1).dateTime;
    }
    return result;
  }

  Future<Map<String, List<Usage>>> getWeeklyUsages() async {
    Map<String, List<Usage>> result = Map();
    DateTime dateTime = DateTime.now();
    for (var i = 0; i < 5; i++) {
      var key = _getWeeklyUsageKey(dateTime);
      List<Usage> data = await _getUsage(weeklyUsage, key);
      result[key] = data;
      dateTime = Jiffy(dateTime).subtract(weeks: 1).dateTime;
    }
    return result;
  }

  Future<Map<String, List<Usage>>> getMonthlyUsages() async {
    Map<String, List<Usage>> result = Map();
    DateTime dateTime = DateTime.now();
    for (var i = 0; i < 12; i++) {
      var key = _getMonthlyUsageKey(dateTime);
      List<Usage> data = await _getUsage(monthlyUsage, key);
      result[key] = data;
      dateTime = Jiffy(dateTime).subtract(months: 1).dateTime;
    }
    return result;
  }

  _getDailyUsageKey(DateTime dateTime) {
    return '${dateTime.year}_${dateTime.month}_${dateTime.day}';
  }

  _getWeeklyUsageKey(DateTime dateTime) {
    return '${dateTime.year}_${dateTime.weekOfYear}';
  }

  _getMonthlyUsageKey(DateTime dateTime) {
    return '${dateTime.year}_${dateTime.month}';
  }

  Future<List<Usage>> _getUsage(String consumptionPeriod, String key) async {
    var result = await _databaseReference
        .child(consumptionPeriod)
        .child(user.uid)
        .child(key)
        .once();
    if (result.value != null) {
      return Usage.fromJsonList(result.value);
    } else {
      return null;
    }
  }

  _updateUsage(String consumptionPeriod, String key, Usage usage) async {
    var result = await _databaseReference
        .child(consumptionPeriod)
        .child(user.uid)
        .child(key)
        .once();

    List<Usage> usages = List.empty();
    if (result.value != null) {
      usages = Usage.fromJsonList(result.value);
    }

    bool categoryExist = false;
    for (Usage current in usages) {
      if (current.category == usage.category) {
        current.weight += usage.weight;
        categoryExist = true;
      }
    }

    var existingUsages = new List<Usage>.from(usages);
    if (categoryExist == false) {
      existingUsages.add(usage);
    }

    _databaseReference
        .child(consumptionPeriod)
        .child(user.uid)
        .child(key)
        .set(Usage.toJsonList(existingUsages));
  }
}
