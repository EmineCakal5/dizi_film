import '../constants/tasktype.dart';

class Task {
  int? id;
  TaskType type;
  String title;
  String description;
  bool isCompleted;
  String rate;

  Task({
    this.id,
    required this.type,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.rate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.index,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'rate': rate,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      type: TaskType.values[map['type']],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
      rate: map['rate'],
    );
  }
}
