import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:time_manager/models/task.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  String _title;
  String _description;
  double _duration = 0;

  void addTask(Task task) {
    final tasksBox = Hive.box('tasks');
    tasksBox.add(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _formKey.currentState.save();
          final newTask = Task(_title, _duration, _description);
          addTask(newTask);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Saved')));
        },
        child: Icon(Icons.save),
      ),
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Title',
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                  ),
                  onSaved: (value) => _title = value,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Duration',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      value: _duration,
                      min: 0,
                      max: 12,
                      divisions: 12,
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
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Task',
                    border: InputBorder.none,
                  ),
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
