import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String taskName;
  final String taskDuration;
  final bool taskCompleted;

  Task(this.taskName, this.taskDuration, this.taskCompleted);

  @override
  List<Object> get props => [
        taskName,
        taskDuration,
        taskCompleted,
      ];
}
