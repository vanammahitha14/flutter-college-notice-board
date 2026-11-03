import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/notice_provider.dart';
import '../widgets/notice_card.dart';
import 'add_notice_screen.dart';
import 'department_screen.dart';
import 'notice_detail_screen.dart';

/// Screen 1: Home Screen – Displays all college notices and handles navigation
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CampusConnect',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter by Department',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DepartmentScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Notices',
            onPressed: () {
              context.read<NoticeProvider>().loadNotices();
            },
          ),
        ],
      ),

      body: Consumer<NoticeProvider>(
        builder: (context, provider, child) {
          // 1. Loading state
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Error state
          if (provider.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 50,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      provider.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        provider.loadNotices();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          // 3. Empty state
          if (provider.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.campaign_outlined,
                      size: 70,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'No notices available',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add your first college notice using the button below.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddNoticeScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Notice'),
                    ),
                  ],
                ),
              ),
            );
          }

          // 4. Data state
          return RefreshIndicator(
            onRefresh: () => provider.loadNotices(),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: provider.notices.length,
              itemBuilder: (context, index) {
                final notice = provider.notices[index];

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
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoticeScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Notice'),
        tooltip: 'Post New Notice',
      ),
    );
  }
}
