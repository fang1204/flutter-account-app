import 'dart:convert';
import 'dart:developer';
import "package:collection/collection.dart";
import 'package:account_app/model/account.dart';
import 'package:account_app/model/bill_data.dart';
import 'package:account_app/model/line.dart';
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

  List _lineChartData=[];
  List<LineData> get balanceLineChartData => _lineChartData[2];
  List<LineData> get incomeLineChartData => _lineChartData[1];
  List<LineData> get expensesLineChartData => _lineChartData[0];

  List _p_n = [0,0];
  List get p_n => _p_n;
  List _tmp=[];
  List get tmp => _tmp;
  String previousData = "";
  void OutputVar() async {
    previousData = await prefs.getBillData();
    if (previousData.isNotEmpty) {
      _tmp = jsonDecode(previousData);
      _totalData = _tmp.map((e) => BillData.fromJson(e)).toList();
    }
    _p_n = cal();
    _chartData = getChartData(_p_n[0],_p_n[1]);
    _lineChartData = getLineChartData(_tmp);

    notifyListeners();
  }

  void decreaseQty(var item) {
    _tmp.remove(item);
    prefs.saveBillData(jsonEncode(_tmp));
    _totalData = _tmp.map((e) => BillData.fromJson(e)).toList();
    _p_n = cal();
    _chartData = getChartData(_p_n[0],_p_n[1]);
    _lineChartData = getLineChartData(_tmp);
    notifyListeners();

  }
  editItem(int editIndex,List allStatus) async {
    log("edit ${editIndex}");

    BillData perData = BillData(
        type: allStatus[3],
        date: allStatus[2],
        itemType: allStatus[1],
        quantity:allStatus[0]
    );

    _tmp.add(perData.toJson());
    _tmp.removeAt(editIndex);
    prefs.saveBillData(jsonEncode(_tmp));
    _totalData = _tmp.map((e) => BillData.fromJson(e)).toList();
    _p_n = cal();
    _chartData = getChartData(_p_n[0],_p_n[1]);
    _lineChartData = getLineChartData(_tmp);

    notifyListeners();
  }


  // List<BillData> get chartData => ;

  List cal() {

    int p_sum = 0;
    int n_sum = 0;

    for (var t in _totalData) {
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

  List getLineChartData(var data){

    data.sort((a, b) {
      return DateTime.parse(a['date']).compareTo(DateTime.parse(b['date']));
    });
    // log("groupByData  ${(data)}");
    List list = [];
    String itemDate = "";
    Map newData = new Map();
    for(var i in data){
      itemDate = i['date'].split(" ")[0];
      int sum = 0;

      // Map newData = new Map();
      if(newData.containsKey(itemDate)){
        if (i['type'] == 0){
          newData[itemDate][0] += i['quantity'];
          newData[itemDate][2]+= i['quantity'];
        }
        else{
          newData[itemDate][1] += i['quantity'];
          newData[itemDate][2] -= i['quantity'];
        }
      }
      else{
        List ans = [0,0,0];     //ans+-=
        if (i['type'] == 0){
          ans[0] += i['quantity'];
          ans[2] += i['quantity'];
        }
        else{
          ans[1] += i['quantity'];
          ans[2] -= i['quantity'];
        }
        newData[itemDate] = ans;
      }
      // list.add(newData);

    }

    final List<LineData> _balanceLineChartData = [];
    final List<LineData> _incomeLineChartData = [];
    final List<LineData> _expensesLineChartData = [];
    newData.forEach((key, value){
      _incomeLineChartData.add(LineData(key,value[0]));
      _expensesLineChartData.add(LineData(key,value[1]));
      _balanceLineChartData.add(LineData(key,value[2]));
    });
    // _incomeLineChartData.add(LineData('2月10日',1111));
    // newData.forEach((key, value) {
    //   _incomeLineChartData.add(LineData('2月10日',value[2]));
    // });
    // log("_incomeLineChartData  ${_incomeLineChartData}");

    _lineChartData = [_incomeLineChartData,_expensesLineChartData,_balanceLineChartData];
    return _lineChartData;
  }




}
