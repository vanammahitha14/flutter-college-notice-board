import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campus_connect/models/notice.dart';
import 'package:campus_connect/services/notice_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Notice Model Tests', () {
    test('Notice serializes to JSON and deserializes from JSON correctly', () {
      final now = DateTime.now();
      final notice = Notice(
        id: '101',
        title: 'Midterm Exam Schedule',
        description: 'Exams begin next Monday at 9:00 AM.',
        department: 'CSE',
        date: now,
        category: 'Exam',
      );

      final json = notice.toJson();
      final restored = Notice.fromJson(json);

      expect(restored.id, '101');
      expect(restored.title, 'Midterm Exam Schedule');
      expect(restored.description, 'Exams begin next Monday at 9:00 AM.');
      expect(restored.department, 'CSE');
      expect(restored.category, 'Exam');
    });
  });

  group('NoticeProvider Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('addNotice adds notice and updates state', () async {
      final provider = NoticeProvider();
      await provider.loadNotices();
      expect(provider.isEmpty, isTrue);

      final notice1 = Notice(
        id: '1',
        title: 'CSE Workshop',
        description: 'Hands-on Flutter workshop.',
        department: 'CSE',
        date: DateTime.now(),
        category: 'Event',
      );

      final notice2 = Notice(
        id: '2',
        title: 'ECE Robotics Lab',
        description: 'Robotics lab orientation.',
        department: 'ECE',
        date: DateTime.now(),
        category: 'Academic',
      );

      await provider.addNotice(notice1);
      await provider.addNotice(notice2);

      expect(provider.notices.length, 2);
      expect(
        provider.notices.first.title,
        'ECE Robotics Lab',
      ); // Most recent first

      // Test department filtering
      final cseNotices = provider.getNoticesByDepartment('CSE');
      expect(cseNotices.length, 1);
      expect(cseNotices.first.title, 'CSE Workshop');

      final allNotices = provider.getNoticesByDepartment('All');
      expect(allNotices.length, 2);

      // Test delete notice
      await provider.deleteNotice('1');
      expect(provider.notices.length, 1);
      expect(provider.notices.first.id, '2');
    });
  });
}
