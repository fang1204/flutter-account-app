import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
class OutcomeChart extends StatelessWidget {
  final dataMap = <String, double>{
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };
  final colorList = <Color>[
    Color(0xfffdcb6e),
    Color(0xff0984e3),
    Color(0xfffd79a8),
    Color(0xffe17055),
    Color(0xff6c5ce7),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 50,
        chartRadius: MediaQuery.of(context).size.width / 3.2,
        colorList: colorList,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 32,
        centerText: "HYBRID",
        /*
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendShape: BoxShape.rectangle,      //圖例的圖標
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),*/
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 1,
        ),
        // gradientList: ---To add gradient colors---
        // emptyColorGradient: ---Empty Color gradient---
      ),
    );
  }
}


