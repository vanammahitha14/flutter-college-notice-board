class Notice {
  final String id;
  final String title;
  final String description;
  final String department;
  final DateTime date;
  final String category;

  Notice({
    required this.id,
    required this.title,
    required this.description,
    required this.department,
    required this.date,
    required this.category,
  });

  // Convert Notice object into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'department': department,
      'date': date.toIso8601String(),
      'category': category,
    };
  }

  // Convert JSON into Notice object
  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      department: json['department'] as String,
      date: DateTime.parse(json['date'] as String),
      category: json['category'] as String,
    );
  }
}
