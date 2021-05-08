part of 'task_bloc.dart';

@immutable
abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskInitialEvent extends TaskEvent {}

class TaskAddEvent extends TaskEvent {
  final String title, description;
  final double duration;

  TaskAddEvent(
      {required this.title, required this.description, required this.duration});
}

class TaskEditEvent extends TaskEvent {
  final String title, description;
  final double duration;
  final int index;

  TaskEditEvent(
      {required this.title,
      required this.description,
      required this.duration,
      required this.index});
}

class TaskDeleteEvent extends TaskEvent {
  final int index;

  TaskDeleteEvent({required this.index});
}
