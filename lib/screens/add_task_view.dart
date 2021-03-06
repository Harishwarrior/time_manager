import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:time_manager/models/task.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  double _duration = 0;

  void addTask(Task task) {
    final tasksBox = Hive.box('tasks');
    tasksBox.add(task);
  }

  Future<bool> saveTask() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newTask = Task(_title, _duration, _description);
      addTask(newTask);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saved'),
          duration: Duration(milliseconds: 700),
        ),
      );
      Navigator.pop(context);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          saveTask();
        },
        icon: Icon(EvaIcons.saveOutline),
        label: Text('Save'),
        tooltip: 'Save task',
      ),
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: TextFormField(
                  style: TextStyle(height: 1.5, fontSize: 22.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some title';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      hintText: 'Title',
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 22)),
                  onSaved: (value) => _title = value!,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _duration,
                      min: 0.0,
                      max: 12.0,
                      divisions: 24,
                      label: '${_duration.toString() + ' hrs'}',
                      onChanged: (double value) {
                        setState(() {
                          _duration = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the description';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Note',
                    border: InputBorder.none,
                  ),
                  onSaved: (value) => _description = value!,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
