import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(InitialTaskState());

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    // TODO: Add your event logic
  }
}
