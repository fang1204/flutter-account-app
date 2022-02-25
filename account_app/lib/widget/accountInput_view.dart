
import 'dart:convert';
import 'dart:developer';

import 'package:account_app/data/home_account_list.dart';
import 'package:account_app/home.dart';
import 'package:account_app/utils/util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sqflite/sqlite_api.dart';
import '../common/object_decoration.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../model/bill_data.dart';
import '../utils/shared_preference_util.dart';
/*
Ting編輯
記帳頁面
 */

class AccountInputView extends StatefulWidget{
  const AccountInputView({Key? key}) : super(key: key);

  @override
  _AccountInputViewState createState() => _AccountInputViewState();
}


class _AccountInputViewState extends State<AccountInputView> {
  //日期
  DateTime selectedDate = DateTime.now();
  DateTime ?_dateTime;
  //輸入金錢
  String money='';
  //選擇收入、支出狀態
  int choice_IncomePay = 0;
  //下拉式選單結果
  String ?selectedValue;
  //下拉式選單index
  int selectedValue_index=0;
  //收入支出
  int ?toggleSwitch_labels;
  //都有填寫才可送出
  bool isButtonAbled = false;

  List allStatus=[];

  TextEditingController myController = TextEditingController();

  //下拉式選單類別
  //收入
  List incomeDropItems=[
    "薪資",
    "打工",
    "獎學金",
    "投資",
    "年終",
    "發票",
    "樂透",
  ];
  //支出
  List payDropItems = [
    '食物',
    '飲料',
    '文具',
    '娛樂',
    '服裝',
    '運動',
    '交通',
    '住宿',
    '3C產品',
    '家俱',
    '保險',
    '醫藥費',
  ];
  //點選後收入or支出要產生的下拉選單
  //預設
  List confirm_IncomePay=[
    "薪資",
    "打工",
    "獎學金",
    "投資",
    "年終",
    "發票",
    "樂透",
  ];
  final Color colorActiveFont = Color.fromARGB(0xff, 250, 244, 220);
  final Color colorI = Color.fromARGB(0xff, 94, 100, 115);
  final Color colorE = Color.fromARGB(0xff, 255, 159, 151);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //最上排
        //調整日期
        centerTitle: true,
        title: ToggleSwitch(
          fontSize:19.sp,
          initialLabelIndex: choice_IncomePay,
          totalSwitches: 2,
          cornerRadius: 10.0,

          activeFgColor: colorActiveFont,//255, 159, 151
          inactiveBgColor: Colors.black12,
          inactiveFgColor: Colors.black,
          activeBgColors: [[colorI],[colorE]],
          labels: const["收入","支出"],
          onToggle: (index) {
            choice_IncomePay = index!;
            setState(() {
              //(selectedValue);
              //切換類別列表
              toggleSwitch_labels = index;
              if (index==0) {
                confirm_IncomePay = incomeDropItems;
              } else {
                confirm_IncomePay = payDropItems;
              }
              //重新設置下拉選單的select value
              selectedValue = null;

            });
          },
        ),
        backgroundColor: const Color.fromARGB(0xFF, 181, 215, 212),
        // foregroundColor :Color.fromARGB(0xff, 64, 102, 99),

      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            // 類別下拉式選單
            Expanded(
              flex: 1,
              child:
              Container(
                alignment: AlignmentDirectional.centerStart,
                padding: const EdgeInsets.all(10),
                child: //下拉選單
                DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: const [
                      Icon(
                        Icons.list,
                        size: 30,
                        color: Color.fromARGB(0xff, 250, 244, 220),
                      ),
                      Expanded(
                        child: Text(
                          '選擇類別',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0, color:Color.fromARGB(0xff, 250, 244, 220)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  value: selectedValue,
                  items:
                  confirm_IncomePay.map((item) =>
                      DropdownMenuItem<String>(
                        value: item,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            item,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:18.sp,
                              // fontWeight: FontWeight.bold,
                              color: colorActiveFont,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                      selectedValue_index = confirm_IncomePay.indexOf(selectedValue);
                      //print(selectedValue);
                      //print(confirm_IncomePay.indexOf(selectedValue));
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 20.sp,
                  iconEnabledColor: Colors.white,
                  //buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color:ChangeColor(choice_IncomePay),
                  ),
                  itemPadding: const EdgeInsets.only(left: 50, right: 50),
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ChangeColor(choice_IncomePay),
                  ),
                  scrollbarRadius: Radius.circular(10),
                  scrollbarThickness: 10,

                ),
              ),

            ),

            /*
            Text(selectedValue == null ? '尚未選擇類型' : selectedValue.toString(),
              style: TextStyle(fontSize: 24.sp,color: ChangeColor(choice_IncomePay)),),*/
            // 日期選擇器
            Expanded(
              flex: 1,
              child: //選擇日期
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*
                    Text(_dateTime == null ? '尚未選擇日期' : _dateTime.toString().substring(0,11),
                        style: TextStyle(fontSize: 20.sp,color: ChangeColor(choice_IncomePay))),*/
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary : ChangeColor(choice_IncomePay)),
                      child: Text(
                        _dateTime == null ? '尚未選擇日期' : _dateTime.toString().substring(0,11),
                        style: TextStyle(fontSize: 20.0, color: colorActiveFont),
                      ),
                      onPressed: (){
                        showDatePicker(
                          context: context,
                          initialDate: _dateTime ?? DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate:  DateTime.now(),
                        ).then((date) {
                          setState(() {
                            _dateTime = date;
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            // 空格
            Expanded(
              flex:6,
              child: Container(

                child: Column(
                  children: <Widget>[
                    TextField(
                      readOnly: true,
                      decoration: new InputDecoration.collapsed(
                          hintText: '請輸入金額'
                      ),
                      controller: myController,
                      style: TextStyle(
                        // decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                          fontSize:24.sp,
                          color: Colors.black
                        // TextFieldDecoration().
                      ),
                      // Text(
                      //   money,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CalculatorKeyboard(
                      onValueChange:(value){
                        setState(() {
                          if(value != "ok"){
                            if (value == "AC"){
                              money = "";
                              myController.text = money;
                              log("123 ${value}");
                            }
                            else{
                              money += value;
                              myController.text = money;

                            }
                          }
                          else{
                            allStatus=  [];
                            allStatus.add(int.parse(myController.text));
                            allStatus.add(confirm_IncomePay.indexOf(selectedValue));
                            allStatus.add(_dateTime.toString());
                            allStatus.add(choice_IncomePay);
                            isButtonAbled = CheckDoneAll(allStatus, isButtonAbled);
                            if(isButtonAbled){
                              Provider.of<HomeAccountList>(context, listen: false).addItem(allStatus);
                              Navigator.pop(context);
                            }
                            else{
                              showAlert(context);
                            }
                          }
                        });
                        print(value);
                      },
                    ),
                  ],
                ),
              ),
            ),
            // 下方的確認或是刪除
            Expanded(
              flex: 1,
              child: //儲存、取消按鈕
              Container(
                height: 20.h,
                width: 60.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close,color: Colors.red,)
                    ),
                    IconButton(
                        onPressed: (){
                          allStatus=  [];
                          allStatus.add(int.parse(myController.text));
                          allStatus.add(confirm_IncomePay.indexOf(selectedValue));
                          allStatus.add(_dateTime.toString());
                          allStatus.add(choice_IncomePay);
                          isButtonAbled = CheckDoneAll(allStatus, isButtonAbled);
                          if(isButtonAbled){
                            Provider.of<HomeAccountList>(context, listen: false).addItem(allStatus);
                            Navigator.pop(context);
                          }
                          else{
                            showAlert(context);
                          }
                        },
                        icon: const Icon(Icons.done,color: Colors.green,)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //變換顏色
  // ChangeColor(int choice_IncomePay){
  //   if(choice_IncomePay==0){
  //     return colorI;
  //   }
  //   else{
  //     return colorE;
  //   }
  // }

  //確認是否全部都有填寫
  CheckDoneAll(List allStatus, bool isButtonAbled){
    for(int i=0;i<allStatus.length;i++){
      if((allStatus[i]=="")|| (allStatus[i]==null)){

        isButtonAbled = false;

        return isButtonAbled;
      }
    }
    isButtonAbled=true;
    return isButtonAbled;

  }

  //沒有填寫則跳出警告
  Future<void> showAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('警告'),
          content: const Text('請注意是否全都有選擇'),
          actions: <Widget>[
            TextButton(
              child: Text('確定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //SharedPreferences存資料
  _save() async {
    SharedPreferenceUtil prefs = SharedPreferenceUtil();
    //要存入的資料
    BillData perData =
    BillData(
        type: choice_IncomePay,
        date: _dateTime.toString(),
        itemType: selectedValue_index,
        quantity:int.parse(money)
    );

    List totalData = [];

    //先前資料
    String previousData = await prefs.getBillData();
    //如果沒取到 代表還沒有存過 轉json存進去並編碼存入
    if(previousData.isEmpty){
      totalData.add(perData.toJson());
      prefs.saveBillData(jsonEncode(totalData));
    }
    //有取到 先解碼再合併目前和現在的
    else{
      totalData = jsonDecode(previousData);
      totalData.add(perData);
      prefs.saveBillData(jsonEncode(totalData));
    }

    print(await prefs.getBillData());



  }


}

final Color colorActiveFont = Color.fromARGB(0xff, 246 , 236, 192);
final Color colorI = Color.fromARGB(0xff, 94, 100, 115);
final Color colorE = Color.fromARGB(0xff, 255, 159, 151);

class CalculatorKeyboard extends StatelessWidget {
  final ValueChanged<String> onValueChange;
  CalculatorKeyboard({Key? key, required this.onValueChange}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Map> _keyboardList = [
      // {'text': '+', 'color':colorActiveFont},
      // {'text': '-', 'color': colorActiveFont},
      // {'text': 'x', 'color':colorActiveFont},
      // {'text': '÷', 'color': colorActiveFont},



      //7 8 9 ÷ ac
      {'text': '7', 'color': colorActiveFont},
      {'text': '8', 'color': colorI},
      {'text': '9', 'color': colorI},
      // {'text': 'AC', 'color':colorActiveFont},

      {'text': '4', 'color': colorI},
      {'text': '5', 'color': colorI},
      {'text': '6', 'color': colorI},
      // {'text': '←', 'color': colorActiveFont},


      {'text': '1', 'color': colorI},
      {'text': '2', 'color': colorI},
      {'text': '3', 'color': colorI},
      {'text': 'AC', 'color':colorActiveFont},

      {'text': '0','color': colorI},
      {'text': 'ok','color':colorI},
      // {'text': '.', 'color': colorI},

    ];
    // return
    return Wrap(
      runSpacing: 30,
      spacing: 50,
      children: List.generate(_keyboardList.length, (index) {
        return CalculatorItem(
          text: _keyboardList[index]['text'],
          color: _keyboardList[index]['color'],
          onValueChange: onValueChange,
        );
      }),
    );
  }
}


class CalculatorItem extends StatelessWidget {
  final String text;
  final Color color;
  final ValueChanged<String> onValueChange;

  CalculatorItem(
      {required this.text,
        // required this.textColor,
        required this.color,
        // required this.highlightColor,
        // required this.height,
        required this.onValueChange});

  @override
  Widget build(BuildContext context) {

    return Ink(
      decoration: BoxDecoration(
          color:colorI,
          border:Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(200))),
      child: InkWell(
        onTap: () {
          onValueChange('$text');
          // log("text_  ${onValueChange(text)}");
        },
        borderRadius: BorderRadius.all(Radius.circular(200)),
        child: Container(
          width:  65,
          height:65,
          padding: EdgeInsets.only(top:10),
          alignment: Alignment.center,
          // alignment: height == null ? Alignment.center : Alignment.centerLeft,
          child: Text(
            '$text',
            style: TextStyle(color: colorE, fontSize: 24),
          ),
        ),
      ),
    );


  }
}


















