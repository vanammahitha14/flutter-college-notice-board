import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/notice.dart';

class NoticeProvider extends ChangeNotifier {
  static const String _storageKey = 'college_notices';

  List<Notice> _notices = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<Notice> get notices => List.unmodifiable(_notices);

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  bool get isEmpty => _notices.isEmpty;

  // Load notices from device storage
  Future<void> loadNotices() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();

      final savedData = prefs.getString(_storageKey);

      if (savedData == null || savedData.isEmpty) {
        _notices = [];
      } else {
        final List<dynamic> decodedData =
            jsonDecode(savedData) as List<dynamic>;

        _notices = decodedData.map((item) {
          return Notice.fromJson(Map<String, dynamic>.from(item as Map));
        }).toList();
      }
    } catch (e) {
      _errorMessage = 'Unable to load notices. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Save notices on device
  Future<void> _saveNotices() async {
    final prefs = await SharedPreferences.getInstance();

    final encodedData = jsonEncode(
      _notices.map((notice) => notice.toJson()).toList(),
    );

    final success = await prefs.setString(_storageKey, encodedData);

    if (!success) {
      throw Exception('Unable to save notices');
    }
  }

  // Add a new notice
  Future<void> addNotice(Notice notice) async {
    _errorMessage = null;

    _notices.insert(0, notice);
    notifyListeners();

    try {
      await _saveNotices();
    } catch (e) {
      _notices.removeWhere((item) => item.id == notice.id);
      _errorMessage = 'Unable to save notice. Please try again.';
      notifyListeners();
      rethrow;
    }
  }

  // Get notices by department
  List<Notice> getNoticesByDepartment(String department) {
    if (department == 'All') {
      return notices;
    }

    return _notices.where((notice) => notice.department == department).toList();
  }

  // Delete a notice
  Future<void> deleteNotice(String id) async {
    final oldNotices = List<Notice>.from(_notices);

    _notices.removeWhere((notice) => notice.id == id);
    notifyListeners();

    try {
      await _saveNotices();
      _errorMessage = null;
    } catch (e) {
      _notices = oldNotices;
      _errorMessage = 'Unable to delete notice. Please try again.';
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}
