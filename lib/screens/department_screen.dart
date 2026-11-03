import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/notice_provider.dart';
import '../widgets/notice_card.dart';
import 'notice_detail_screen.dart';

/// Screen 4: Department Screen – Filter and view notices by department
class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({super.key});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  final List<String> _departments = const [
    'All',
    'CSE',
    'ECE',
    'EEE',
    'IT',
    'Mechanical',
    'Civil',
    'General',
  ];

  String _selectedDepartment = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Department Notices')),
      body: Column(
        children: [
          // Horizontal Filter Chips
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _departments.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final dept = _departments[index];
                  final isSelected = dept == _selectedDepartment;

                  return ChoiceChip(
                    label: Text(dept),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedDepartment = dept;
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ),

          // Filtered Notices List
          Expanded(
            child: Consumer<NoticeProvider>(
              builder: (context, provider, child) {
                final filteredNotices = provider.getNoticesByDepartment(
                  _selectedDepartment,
                );

                if (filteredNotices.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.filter_list_off,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _selectedDepartment == 'All'
                                ? 'No notices available.'
                                : 'No notices for $_selectedDepartment department.',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Switch to another department or add a new notice.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: filteredNotices.length,
                  itemBuilder: (context, index) {
                    final notice = filteredNotices[index];
                    return NoticeCard(
                      notice: notice,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NoticeDetailScreen(notice: notice),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
