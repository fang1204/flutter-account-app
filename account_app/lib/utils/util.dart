
import 'dart:developer';

import 'package:account_app/data/home_account_list.dart';
import 'package:account_app/utils/shared_preference_util.dart';
import 'package:account_app/widget/items_view.dart';

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

// List cal(List p_n, int t,int quantity ){
//
//   if (t == 0){
//       p_sum = p_sum + quantity!;
//     }
//   else  if (t == 1){
//       n_sum = n_sum + quantity!;
//     }
//   return p_n;
// }

// List<BillData> bill=[];
// Future<List> cal()  async {
//
//
//   bill  = await HomeAccountList().OutputVar();
//   int p_sum=0, n_sum=0;
//   List p_n=[];
//   for (var value in bill){
//
//     if (value.type == 0){
//
//       p_sum = p_sum + value.quantity!;
//     }
//     if (value.type == 1){
//       n_sum = n_sum + value.quantity!;
//     }
//   }
//   p_n.add(p_sum);
//   p_n.add(n_sum);
//
//
//   // previousData = bill;
//
//   return p_n;
//
// }

// Future<List<BillData>> OutputVar() async {
//   SharedPreferenceUtil prefs = SharedPreferenceUtil();
//   List<BillData> totalData = [];
//   String previousData="";
//   // String json = jsonEncode(previousDataDecode);
//   previousData = await prefs.getBillData();
//   log("previousData$previousData");
//   if (previousData.isNotEmpty){
//     List tmp = jsonDecode(previousData);
//     totalData = tmp.map((e) => BillData.fromJson(e)).toList();
//
//   }
//   print("************");
//   print(totalData);
//
//
//   return totalData;
//
//
//   //如果取得資料為null代表使用者第一次存取
//
// }

