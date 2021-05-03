import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:time_manager/models/task.dart';

class UpdateNotes extends StatefulWidget {
  UpdateNotes({required this.box, required this.task, required this.index});
  final Box box;
  final Task task;
  final int index;

  @override
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<UpdateNotes> {
  Future<void> updateNote(int index, String newDescription, String newTitle,
      double duration) async {
    final newTask = Task(newTitle, duration, newDescription);
    final box = widget.box;
    await box.putAt(index, newTask);
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    var title = widget.task.taskTitle;
    var description = widget.task.taskDescription;
    var duration = widget.task.taskDuration;
    var index = widget.index;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('UPDATE'),
        tooltip: 'Update task',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            updateNote(index, description, title, duration);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Updated'),
                duration: Duration(milliseconds: 700),
              ),
            );
            Navigator.pop(context);
          }
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      style: TextStyle(height: 1.5, fontSize: 22.0),
                      initialValue: widget.task.taskTitle,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some title';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        title = text;
                      },
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          hintText: 'Title',
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 22)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      initialValue: widget.task.taskDescription,
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
                      onChanged: (text) {
                        description = text;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Slider(
                  //   value: duration,
                  //   min: 0.0,
                  //   max: 12.0,
                  //   divisions: 24,
                  //   label: '${duration.toString() + ' hrs'}',
                  //   onChanged: (double value) {
                  //     setState(() {
                  //       duration = value;
                  //     });
                  //   },
                  // ),
                ],
              )),
        ),
      ),
    );
  }
}
