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

