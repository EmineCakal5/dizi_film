import 'package:der_3/constants/tasktype.dart';

class Task{
  Task({
    required this.type,
    required this.title,
    required this.description,
    required this.isCompleted,

  }
  );
  final TaskType type;
  final String title;
  final String description;
   bool isCompleted;
}