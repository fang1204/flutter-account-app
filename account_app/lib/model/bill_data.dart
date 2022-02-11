

List<BillData> fakeData = [
  BillData(
  type: Type.INCOME,
  date: "2022-02-11 14:05:39.233415",
    itemType: IncomeTypes.SCHOLARSHIP,
    quantity:1000
  ),
  BillData(
      type: Type.PAY,
      date: DateTime.now().toString(),
      itemType: PayTypes.HOTEL,
      quantity: 1000
  ),
  BillData(
      type: Type.PAY,
      date: "2022-01-11 14:05:39.233415",
      itemType: PayTypes.DRESS,
      quantity: 800
  ),
  BillData(
      type: Type.INCOME,
      date: "2022-02-10 14:05:39.233415",
      itemType: IncomeTypes.LOTTO,
      quantity: 2000
  ),
];

class BillData{
  ///class=>TYPE
  int? type;
  ///時間
  String? date;
  ///金額
  int? quantity;
  ///項目(收入支出的類別)
  int? itemType;

  BillData({required this.date,required this.itemType,required this.quantity,required this.type});


  BillData.fromJson(Map<String,dynamic> json){
    type = json['type'];
    date = json['date'];
    quantity = json['quantity'];
    itemType = json['item_type'];
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'date': date,
    'quantity': quantity,
    'itemType': itemType,
  };
}
class Type{
  static int INCOME = 0;
  static int PAY = 1;
}
class IncomeTypes {
  // 0 "薪資",
  // 1 "獎學金",
  // 2 "投資",
  // 3 "年終",
  // 4 "發票",
  // 5 "樂透",
  static int PAY = 0;
  static int SCHOLARSHIP = 1;
  static int INVEST = 2;
  static int YEARENDBONUS = 3;
  static int INVOICE = 4;
  static int LOTTO = 5;
}
class PayTypes {
  // 0 '食物',
  // 1 '飲料',
  // 2 '文具',
  // 3 '娛樂',
  // 4 '服裝',
  // 5 '運動',
  // 6 '交通',
  // 7 '住宿',
  // 8 '3C產品',
  // 9  '家俱',
  // 10 '保險',
  // 11 '醫藥費',
static int FOOD = 0;
static int DRINK = 1;
static int STATIONERY = 2;
static int PLAY = 3;
static int DRESS = 4;
static int APORT = 5;
static int TRAFFIC = 6;
static int HOTEL = 7;
static int THREECPRODUCT = 8;
static int FURNITURE = 9;
static int INSURANCE = 10;
static int MEDICALEXPENSES = 11;
}