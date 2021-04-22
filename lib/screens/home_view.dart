import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:time_manager/models/task.dart';
import 'package:time_manager/screens/add_task_view.dart';
import 'package:time_manager/utils/media_query.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Time Manager'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('tasks').listenable(),
        builder: (BuildContext context, taskBox, Widget child) {
          return ListView.builder(
            itemCount: taskBox.length,
            itemBuilder: (BuildContext context, int index) {
              final task = taskBox.getAt(index) as Task;
              return CardView(context, index, task);
            },
          );
        },
      ),
    );
  }
}

Widget CardView(BuildContext context, int index, Task task) {
  return Card(
    child: Container(
      margin: EdgeInsets.all(8.0),
      height: displayHeight(context) * 0.07,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.taskTitle),
          Expanded(
            child: LinearPercentIndicator(
              lineHeight: displayHeight(context) * 0.02,
              percent: task.taskDuration.toDouble() / 12,
              progressColor: Colors.teal,
            ),
          ),
        ],
      ),
    ),
    elevation: 0.5,
  );
}
