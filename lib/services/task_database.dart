import 'package:hive/hive.dart';

import 'dart:async';

import 'package:time_manager/models/task.dart';

class TaskDatabase {
  final String _boxName = 'tasks';
  Future<Box> taskBox() async {
    var box = await Hive.openBox<Task>(_boxName);
    return box;
  }

  Future<List<Task>> getFullTask() async {
    final box = await taskBox();
    var tasks = box.values as List<Task>;
    return tasks;
  }

  Future<void> addToBox(Task task) async {
    final box = await taskBox();

    await box.add(task);
  }

  Future<void> deleteFromBox(int index) async {
    final box = await taskBox();
    await box.deleteAt(index);
  }

  Future<void> deleteAll() async {
    final box = await taskBox();
    await box.clear();
  }

  Future<void> updateTask(int index, Task task) async {
    final box = await taskBox();
    await box.putAt(index, task);
  }
}
