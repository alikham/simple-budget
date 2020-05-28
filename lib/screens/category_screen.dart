import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/expense_model.dart';
import '../helpers/radial_painter.dart';
import '../helpers/color_helper.dart';



class CategoryScreen extends StatefulWidget{
    final Category category;

    CategoryScreen({this.category});

    @override
    _CategoryScreenState createState()=> _CategoryScreenState();

}

class _CategoryScreenState extends State<CategoryScreen>{
    
    @override
    Widget build(BuildContext context){
        double totalAmountSpent = 0;
        widget.category.expenses.forEach((Expense expense){
            totalAmountSpent += expense.cost;
        });

        double amountLeft = widget.category.maxAmount-totalAmountSpent;
        double percent = amountLeft/widget.category.maxAmount;

        _buildExpenses(){
            List<Widget> expenses = [];
             widget.category.expenses.forEach((Expense expense){
                 expenses.add( Container(
                     margin:EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                     padding: EdgeInsets.symmetric(horizontal: 20.0),
                     height: 80.0,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10.0),
                         color:Colors.white,
                        boxShadow: [BoxShadow(
                            offset: Offset(0,2),
                            blurRadius: 6.0,
                            color: Colors.black12,
                        ),]
                     ),
                     child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children:<Widget>[
                             Text(expense.name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
                             Text('-\$${expense.cost.toStringAsFixed(2)}', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color:Colors.red))
                         ],
                     ),
                 ));

             });
            return Column(children: expenses);
        }

        return Scaffold(
            appBar: AppBar(
                title: Text(widget.category.name),
                centerTitle: true,
                actions:[
                    IconButton(
                        icon: Icon(Icons.add),
                        onPressed:(){},
                    ),
                ]
            ),
            body: SingleChildScrollView(
                child:Column(
                    children:<Widget>[
                        Container(
                            height: 250.0,
                            width: double.infinity,
                            margin: EdgeInsets.all(20.0),
                            padding: EdgeInsets.all(20.0),
                            decoration : BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6.0,
                                        offset: Offset(0,2),
                                    ),
                                ],
                            ),
                            child:CustomPaint(
                                foregroundPainter: RadialPainter(bgColor:Colors.grey[100],lineColor: getColor(context, percent), percent: percent, width: 20.0),
                                child:Center(
                                    child: Text('\$${amountLeft.toStringAsFixed(2)}/${widget.category.maxAmount}', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
                                ),
                            ),
                        ),
                        _buildExpenses(),
                    ],
                ),
            ),
        );
    }
}