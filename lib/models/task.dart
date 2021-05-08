import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String taskTitle;
  @HiveField(1)
  final String taskDescription;
  @HiveField(2)
  final double taskDuration;

  Task(this.taskTitle, this.taskDescription, this.taskDuration);
}
