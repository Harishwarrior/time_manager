import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:time_manager/models/task.dart';
import 'package:time_manager/services/task_database.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskDatabase _taskDatabase;
  List<Task> _tasks = [];
  TaskBloc(this._taskDatabase) : super(TaskInitial());

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is TaskInitialEvent) {
      yield* _mapInitialEventToState();
    }
    if (event is TaskAddEvent) {
      yield* _mapTaskAddEventToState(
          title: event.title,
          description: event.description,
          duration: event.duration);
    }
    if (event is TaskEditEvent) {
      yield* _mapTaskEditEventToState(
          title: event.title,
          content: event.description,
          index: event.index,
          duration: event.duration);
    }
    if (event is TaskDeleteEvent) {
      yield* _mapTaskDeleteEventToState(index: event.index);
    }
  }

  //STREAM FUNCTIONS

  Stream<TaskState> _mapInitialEventToState() async* {
    yield TaskLoading();

    await _getTasks();

    yield YourTaskState(tasks: _tasks);
  }

  Stream<TaskState> _mapTaskAddEventToState(
      {required String title,
      required String description,
      required double duration}) async* {
    yield TaskLoading();
    await _addToTasks(
        title: title, description: description, duration: duration);
    yield YourTaskState(tasks: _tasks);
  }

  Stream<TaskState> _mapTaskEditEventToState(
      {required String title,
      required String content,
      required int index,
      required double duration}) async* {
    yield TaskLoading();
    await _updateTask(
        newTitle: title,
        newDescription: content,
        index: index,
        newDuration: duration);
    yield YourTaskState(tasks: _tasks);
  }

  Stream<TaskState> _mapTaskDeleteEventToState({required int index}) async* {
    yield TaskLoading();
    await _removeFromTasks(index: index);
    _tasks.sort((a, b) {
      var aDate = a.taskTitle;
      var bDate = b.taskDescription;
      return aDate.compareTo(bDate);
    });
    yield YourTaskState(tasks: _tasks);
  }

  //HELPER FUNCTIONS

  Future<void> _getTasks() async {
    await _taskDatabase.getFullTask().then((value) {
      _tasks = value;
    });
  }

  Future<void> _addToTasks(
      {required String title,
      required String description,
      required double duration}) async {
    await _taskDatabase.addToBox(Task(title, description, duration));
    await _getTasks();
  }

  Future<void> _updateTask(
      {required int index,
      required String newTitle,
      required String newDescription,
      required double newDuration}) async {
    await _taskDatabase.updateTask(
        index, Task(newTitle, newDescription, newDuration));
    await _getTasks();
  }

  Future<void> _removeFromTasks({required int index}) async {
    await _taskDatabase.deleteFromBox(index);
    await _getTasks();
  }
}
