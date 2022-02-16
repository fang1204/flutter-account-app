import 'dart:convert';
import 'dart:developer';

import 'package:account_app/model/account.dart';
import 'package:account_app/model/bill_data.dart';
import 'package:account_app/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/pie.dart';
import '../utils/shared_preference_util.dart';

class HomeAccountList extends ChangeNotifier {
  SharedPreferenceUtil prefs = SharedPreferenceUtil();
  List<BillData> _totalData = [];
  List<BillData> get totalData => _totalData;


  List<IEData> _chartData=[];
  List<IEData> get chartData => _chartData;
  List _p_n = [];
  List get p_n => _p_n;
  String previousData = "";
  void OutputVar() async {

    previousData = await prefs.getBillData();

    if (previousData.isNotEmpty) {
      List tmp = jsonDecode(previousData);
      _totalData = tmp.map((e) => BillData.fromJson(e)).toList();
    }
    _p_n = cal();
    _chartData = getChartData(_p_n[0],_p_n[1]);
    // log("previousData${previousData}");
    // log("totalData ${_totalData}");


    // cal();
    notifyListeners();
  }


  // List<BillData> get chartData => ;

  List cal() {

    int p_sum = 0;
    int n_sum = 0;

    for (var t in totalData) {
      if (t.type == 0) {
        p_sum = p_sum + t.quantity!;
      } else if (t.type == 1) {
        n_sum = n_sum + t.quantity!;
      }
    }


    // log("chartData ${chartData}");
    return [p_sum, n_sum];
  }


  List<IEData> getChartData(int p_sum,int n_sum){

    final List<IEData> _chartData = [
      IEData('收入', p_sum),
      IEData('支出', n_sum),
    ];
    return _chartData;
  }


/*
  List p_n = [0, 0];
  List<BillData> _totalData = [];

  @override




    _totalData =await HomeAccountList().OutputVar() ;

    log("******$_totalData");
    for(var t in _totalData){
      if (t.type == 0){
        p_sum = p_sum + t.quantity!;
      }
      else  if (t.type == 1){
        n_sum = n_sum + t.quantity!;
      }
    }
    p_n[0] = p_sum;
    p_n[1] = n_sum;

    setState(() {
      _chartData = getChartData();
    });
  }*/

}
