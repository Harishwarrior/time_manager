import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:time_manager/models/task.dart';
import 'package:time_manager/screens/add_task_view.dart';
import 'package:time_manager/screens/settings_view.dart';
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
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.settings,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (SettingsPage())),
                );
              }),
        ],
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
        builder: (BuildContext context, Box box, Widget? child) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (BuildContext context, int index) {
              final task = box.getAt(index) as Task;
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    box.deleteAt(index);
                  });
                },
                child: CardView(context, index, task),
              );
            },
          );
        },
      ),
    );
  }
}

Widget CardView(BuildContext context, int index, Task task) {
  return ExpansionTile(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(task.taskTitle),
        LinearPercentIndicator(
          center: Text('${task.taskDuration.toString()} hrs'),
          width: displayWidth(context) * 0.5,
          lineHeight: displayHeight(context) * 0.02,
          percent: task.taskDuration / 12,
          progressColor: Colors.teal,
        ),
      ],
    ),
    children: [
      Container(
        margin: EdgeInsets.all(16.0),
        height: displayHeight(context) * 0.07,
        child: SingleChildScrollView(
          child: Text(
            task.taskDescription,
            style: TextStyle(),
          ),
        ),
      ),
    ],
  );
}
