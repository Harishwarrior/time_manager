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
                child: CustomListView(context, index, task),
              );
            },
          );
        },
      ),
    );
  }
}

Widget CustomListView(BuildContext context, int index, Task task) {
  return Card(
    margin: EdgeInsets.all(8.0),
    elevation: 5.0,
    color: Theme.of(context).backgroundColor,
    child: ExpansionTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 15.0, top: 15.0),
            child: Text(
              task.taskTitle,
              style: TextStyle(fontSize: 20.0),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 15.0),
            child: LinearPercentIndicator(
              center: Text('${task.taskDuration.toString()} hrs'),
              lineHeight: displayHeight(context) * 0.02,
              animation: true,
              animationDuration: 1500,
              restartAnimation: true,
              percent: task.taskDuration / 12,
              progressColor: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
              child: Text(
                task.taskDescription,
                style: TextStyle(),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
