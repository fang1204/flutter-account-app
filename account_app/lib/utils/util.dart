

import 'dart:convert';

import 'package:account_app/utils/shared_preference_util.dart';

import '../model/bill_data.dart';

List typeToList(int t, int typeName){
    String s, p_n;

    var list0 = ["薪資","獎學金","投資","年終","發票","樂透","打工"];
    var list1 = ["食物","飲料","文具","娛樂","服裝","運動","交通","住宿","3C產品","家俱","保險","醫藥費"];
    if (t==0){
      s = list0[typeName];
      p_n = "";
    }
    else{
      s = list1[typeName];
      p_n = "-";
    }
    // _chartData = BillItem();
    // _tooltipBehavior = TooltipBehavior(enable: true);
    // super.initState();
    return [s, p_n];
}

List cal(){
  List<BillData> _bill = fakeData;
  int p_sum = 0;
  int n_sum = 0;
  for (var value in _bill){

    if (value.type == 0){

      p_sum = p_sum + value.quantity!;
    }
    if (value.type == 1){
      n_sum = n_sum + value.quantity!;
    }
  }
  return [p_sum, n_sum];
}
Future<List<BillData>> OutputVar() async {
  SharedPreferenceUtil prefs = SharedPreferenceUtil();
  List<BillData> total_data = [];
  String previousData;
  List previousDataDecode;
  bool firstKeep =false;

    previousData= await prefs.getBillData();
    previousDataDecode = jsonDecode(previousData);
     print(previousDataDecode);
    for(String data in previousDataDecode){
      total_data.add(BillData.fromJson(jsonDecode(data)));
    }
  return total_data;

  //如果取得資料為null代表使用者第一次存取


  print("************");
  // print(ss.runtimeType);

  // for (var value in ss){
  //   print(ss);
  // }



}


