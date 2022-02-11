
String typeToString(int t, int typeName){
  String s;
  var list0 = ["薪資","獎學金","投資","年終","發票","樂透"];
  var list1 = ["食物","飲料","文具","娛樂","服裝","運動","交通","住宿","3C產品","家俱","保險","醫藥費"];
  if (t==0){
    s = list0[typeName];

  }
  else{
    s = list1[typeName];
  }
  // _chartData = BillItem();
  // _tooltipBehavior = TooltipBehavior(enable: true);
  // super.initState();
  return s;
}