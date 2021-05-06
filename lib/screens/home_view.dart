import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:time_manager/models/task.dart';
import 'package:time_manager/screens/add_task_view.dart';
import 'package:time_manager/screens/settings_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'update_task_view.dart';

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
                EvaIcons.settingsOutline,
                semanticLabel: 'settings',
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (SettingsPage())),
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(_createRoute());
        },
        tooltip: 'New task',
        icon: Icon(EvaIcons.fileAddOutline),
        label: Text('New'),
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
                  margin: EdgeInsets.all(8.0),
                  color: Colors.red,
                  child: Icon(EvaIcons.trashOutline),
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

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AddTask(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Widget CustomListView(BuildContext context, int index, Task task) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return UpdateTasks(
          box: Hive.box('tasks'),
          task: task,
          index: index,
        );
      }));
    },
    child: Card(
      margin: EdgeInsets.all(8.0),
      elevation: 10.0,
      color: Theme.of(context).backgroundColor,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Hero(
              tag: 'titleHero',
              child: Text(
                task.taskTitle,
                style: TextStyle(fontSize: 18.0),
                maxLines: 5,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
            child: LinearPercentIndicator(
              center: Text('${task.taskDuration.toString()} hrs'),
              lineHeight: 15,
              animation: true,
              animationDuration: 1000,
              percent: task.taskDuration / 12,
              progressColor: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    ),
  );
}
