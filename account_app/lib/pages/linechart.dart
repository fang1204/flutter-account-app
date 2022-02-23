import 'package:account_app/model/line.dart';
import "package:flutter/material.dart";
import 'package:account_app/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/home_account_list.dart';


class LineChart extends StatefulWidget {
  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //最上排
        title: Text('折線圖'), //折線圖
        backgroundColor: const Color.fromARGB(0xFF, 181, 215, 212),
        foregroundColor: Color.fromARGB(0xff, 64, 102, 99),
      ),
      body: Container(
        child: GestureDetector(
          child: Consumer<HomeAccountList>(builder: (context, data, child) {
            // log("OutcomeChart chartData  ${data.chartData}");
            return SafeArea(
                child: Scaffold(
                  body: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
                        LineSeries<LineData, String>(
                            dataSource: data.balanceLineChartData,
                            xValueMapper: (LineData line, _) => line.year,
                            yValueMapper: (LineData line, _) => line.sales),
                      LineSeries<LineData, String>(
                          dataSource: data.incomeLineChartData,
                          xValueMapper: (LineData line, _) => line.year,
                          yValueMapper: (LineData line, _) => line.sales),
                      LineSeries<LineData, String>(
                          dataSource: data.expensesLineChartData,
                          xValueMapper: (LineData line, _) => line.year,
                          yValueMapper: (LineData line, _) => line.sales)
                      ],
                  ),
                ));
          }),
          onTap: (){
            // Navigator.pop(context);
            // Navigator.pop(context);
            Navigator.pushReplacementNamed(context, "/home");
          },
        ),
      ),
    );
  }
}


/*
class LineChart extends StatelessWidget {
  
  Future<bool?> showWarning(BuildContext context) async=> showDialog<bool>(
    context:  context,
      
    
    builder: (context) =>AlertDialog(
      title:Text("Do you want to exit?"),
      actions: [
        ElevatedButton(
          child: Text('No'),
            onPressed: (){

            }
          // onPressed: () =>Navigator.pop(context,false),
        ),
        ElevatedButton(
          child: Text('Yes'),
            onPressed: (){

            }
          // onPressed: () =>Navigator.pop(context,true),
        ),
      ],
    ),
    
  );


  @override
  Widget build(BuildContext context) =>WillPopScope(
      onWillPop: ()async{
        final  shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child:Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0xFF, 181, 215, 212),
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
        ),
        title: Text('LineChart'),
      ),
      body: OutcomeChart(),
    ),);
  }


class OutcomeChart extends StatefulWidget {
  @override
  _OutcomeChartState createState() => _OutcomeChartState();
}

class _OutcomeChartState extends State<OutcomeChart> {
  late List<SalesData> _chartData;
  @override
  void initState() {
    _chartData = getCharData();
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return SafeArea(
        child: Scaffold(
          body: SfCartesianChart(series: <ChartSeries>[
            LineSeries<SalesData,double>(dataSource: _chartData,
                xValueMapper: (SalesData sales,_)=> sales.day,
                yValueMapper: (SalesData sales,_)=> sales.sales)
          ],),
        ));
  }

  List<SalesData> getCharData(){
    final List<SalesData> chartData =[
      SalesData(210,25),
      SalesData(211,21),
      SalesData(212,29),
      SalesData(213,10),
      SalesData(214,36),
    ];
    return chartData;
  }
}

class SalesData{
  SalesData(this.day,this.sales);
  final double day;
  final double sales;
}
*/
