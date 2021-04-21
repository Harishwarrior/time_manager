import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
        body: Container(
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
              return CardView(context, index);
            },
          ),
        ));
  }
}

Widget CardView(BuildContext context, int index) {
  return Card(
    child: Container(
      margin: EdgeInsets.all(8.0),
      height: displayHeight(context) * 0.07,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Task ${index + 1}'),
          Expanded(
            child: LinearPercentIndicator(
              lineHeight: displayHeight(context) * 0.02,
              percent: 0.2,
              progressColor: Colors.teal,
            ),
          ),
        ],
      ),
    ),
    elevation: 0.5,
  );
}
