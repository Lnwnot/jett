import 'package:flutter/material.dart';

class ClassProvider with ChangeNotifier {
  List<Map<String, dynamic>> bookedClasses = [];
  List<Map<String, dynamic>> checkedInClasses = [];
  List<Map<String, dynamic>> canceledClasses = [];

  void addClass(Map<String, dynamic> newClass) {
    if (!bookedClasses.any((c) => c["title"] == newClass["title"])) {
      bookedClasses.add(newClass);
      notifyListeners();
    }
  }

  void cancelClass(Map<String, dynamic> classToCancel) {
    bookedClasses.removeWhere((c) => c["title"] == classToCancel["title"]);
    canceledClasses.add(classToCancel);
    notifyListeners();
  }

  void checkInClass(Map<String, dynamic> classData) {
    if (!checkedInClasses.any((c) => c["title"] == classData["title"])) {
      bookedClasses.removeWhere((c) => c["title"] == classData["title"]);
      checkedInClasses.add(classData);
      notifyListeners();
    }
  }

  bool isCheckedIn(String classTitle) {
    return checkedInClasses.any((c) => c["title"] == classTitle);
  }
}