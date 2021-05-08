part of 'task_bloc.dart';

@immutable
abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskEditing extends TaskState {
  final Task task;

  TaskEditing({required this.task});
  @override
  List<Object> get props => [task];
}

class YourTaskState extends TaskState {
  final List<Task> tasks;

  YourTaskState({required this.tasks});
  @override
  List<Object> get props => [tasks];
}

class NewTaskState extends TaskState {}
