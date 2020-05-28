import 'package:flutter/material.dart';
import '../data/data.dart';
import '../widgets/bar_chart.dart';
import '../models/category_model.dart';
import '../helpers/color_helper.dart';
import 'category_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildCategoryItem(Category category, double totalExpenses){
    return 
    GestureDetector(
      onTap: (){ 
        Navigator.push( context, MaterialPageRoute(builder: (_)=>CategoryScreen(category: category)));
      },
    child:Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: EdgeInsets.all(20.0),
      width: double.infinity,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow:[
          BoxShadow(
            color:Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
        ),
      child: Column(
          mainAxisAlignment : MainAxisAlignment.center,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget>[
              Text(category.name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
              Text('\$ ${(category.maxAmount - totalExpenses).toStringAsFixed(2)}/\$${category.maxAmount}', style: TextStyle(fontSize: 18.0, )),
            ],
            ),
            SizedBox(height: 10.0),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints){
                final double maxBarWidth = constraints.maxWidth;
                final double percent = (category.maxAmount - totalExpenses )/category.maxAmount;
                double barWidth = percent * maxBarWidth;
                if(barWidth < 0){
                  barWidth = 0;
                }

                return Stack(
                  children: <Widget>[
                    Container(
                      height: 20.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                      ),
                    ),
                    Container(
                      height: 20.0,
                      width : barWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: getColor(context, percent),
                      ),
                    ),
                  ],
                );
              } 
            ),
           
          ],
        ),
    ),
    );
    
  }

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
                if(index == 0){
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
                }else{
                  Category category = categories[index -1];
                  double totalExpenses = 0;
                  category.expenses.forEach((expense){
                    totalExpenses += expense.cost;
                  });
                  return _buildCategoryItem(category, totalExpenses);
                }
              },
              childCount: 1+ categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
