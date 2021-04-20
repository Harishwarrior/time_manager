import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
          onPressed: () {},
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Task ${index + 1}'),
          LinearPercentIndicator(
            width: displayWidth(context) * 0.5,
            lineHeight: displayHeight(context) * 0.02,
            percent: 0.2,
            progressColor: Colors.teal,
          ),
        ],
      ),
    ),
    elevation: 0.5,
  );
}
