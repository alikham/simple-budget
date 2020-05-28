import 'package:flutter/material.dart';
import '../widgets/bar_chart.dart';
import '../data/data.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 100.0,
            forceElevated: true,
            floating: true,
            leading: Icon(Icons.settings),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Simple Budget'),
              centerTitle: true,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {},
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  margin:EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.black12,
                        offset: Offset(0,2),
                        blurRadius: 6.0,

                      )
                    ],
                  ),
                  child: BarChart(weeklySpending),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
