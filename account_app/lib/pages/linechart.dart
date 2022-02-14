import "package:flutter/material.dart";
import 'package:account_app/utils/util.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class LineChart extends StatelessWidget {
  const LineChart({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
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

