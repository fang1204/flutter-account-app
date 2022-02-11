//雯坊
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/pie.dart';



class OutcomeChart extends StatefulWidget {
  @override
  _OutcomeChartState createState() => _OutcomeChartState();
}

class _OutcomeChartState extends State<OutcomeChart> {

  late List<IEData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  @override

  void initState(){
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SfCircularChart(
            title: ChartTitle(text: 'Income and Expenses'),
            legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                //         legendShape: BoxShape.circle,
                position: LegendPosition.bottom
            ),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              DoughnutSeries<IEData, String>(
                dataSource: _chartData,
                xValueMapper: (IEData data, _) => data.s,
                yValueMapper: (IEData data, _) => data.num,
                dataLabelSettings: DataLabelSettings(isVisible: true),
                enableTooltip: true,
                explode: true,
                explodeAll: true,
                // explodeOffset: '10%',
              )
            ],

          ),
    ));
  }
  List<IEData> getChartData(){
    final List<IEData> chartData = [
      IEData('aa', 10),
      IEData('bb', 20),
    ];
    return chartData;
  }
}
// class IEData {
//
//   IEData(this.s, this.num);
//   final String s;
//   final int num;
//
// }

// class OutcomeChart extends StatelessWidget {
//
//   late List<IncomeExpenseData> _chartData;
//
//   @override
//   void initState(){
//     _chartData = getChartData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final Color color_income = Color.fromARGB(0xFF, 250, 175, 165);
//     // final Color color_expense =Color.fromARGB(0xFF, 189, 215, 238);
//
//
//     return SafeArea(
//       child: Scaffold(
//           body: SfCartesianChart(
//             series: <CircularSeries>[
//               PieSeries<IncomeExpenseData, String>(
//                 dataSource: _chartData,
//                 xValueMapper: (IncomeExpenseData data, _) => data.x,
//                 yValueMapper: (IncomeExpenseData data, _) => data.y,
//                 dataLabelSettings: DataLabelSettings(isVisible: true)
//               )
//             ],
//           )
//       ),
//     );
//   }
//   List<IncomeExpenseData> getChartData(){
//     final List<IncomeExpenseData> chartData = [
//       IncomeExpenseData('收入',  25.0),
//       IncomeExpenseData('支出', 5.0),
//
//     ];
//     return chartData;
//   }
//
//
//
//   /*
//   Widget build(BuildContext context) {
//     return PieChart(
//       dataMap: dataMap,
//       animationDuration: const Duration(milliseconds: 800),
//       chartLegendSpacing: 32,
//
//       chartRadius: MediaQuery.of(context).size.width / 3.2,
//       colorList: colorList,
//       initialAngleInDegree: 0,
//       chartType: ChartType.ring,
//       ringStrokeWidth: 32,
//       centerText: "HYBRID",
//
//       legendOptions: const LegendOptions(
//         showLegendsInRow: true,
//         legendPosition: LegendPosition.bottom,
//         showLegends: true,
//         legendShape: BoxShape.circle,      //圖例的圖標
//         legendTextStyle: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       chartValuesOptions: const ChartValuesOptions(
//
//         showChartValueBackground: true,
//         showChartValues: true,
//         showChartValuesInPercentage: false,
//         showChartValuesOutside: true,
//         decimalPlaces: 1,
//       ),
//       // gradientList: ---To add gradient colors---
//       // emptyColorGradient: ---Empty Color gradient---
//     );
//   }*/
// }






