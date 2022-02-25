import 'dart:developer';

import 'package:account_app/data/home_account_list.dart';
import 'package:account_app/model/account.dart';
import 'package:account_app/note/note_page.dart';
import 'package:account_app/pages/User.dart';
import 'package:account_app/pages/linechart.dart';
import 'package:account_app/pages/setting.dart';
import 'package:account_app/utils/util.dart';
import 'package:account_app/widget/accountInput_view.dart';
import 'package:account_app/widget/card_view.dart';
import 'package:account_app/widget/groupedlist_view.dart';

import 'package:account_app/widget/list_view.dart';
import 'package:account_app/widget/pieCharts_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeAccountList? homeAccountList;
  final YearMonth = "";
  final Color colorFont = Color.fromARGB(0xff, 64, 102, 99);
  final Color colorback = Color.fromARGB(0xFF, 181, 215, 212);

  final DateFormat formatter = DateFormat('yyyy月MM');
  // int _pickerYear = DateTime.now().year;
  // DateTime _selectedMonth = DateTime(
  //   DateTime.now().year,
  //   DateTime.now().month,
  //   1,
  // );
  // dynamic pickerOpen = false;
  // void switchPicker() {
  //   pickerOpen = true;
  // }
  //
  List<Widget> generateRowOfMonths(from, to) {
    List<Widget> months = [];
    for (int i = from; i <= to; i++) {
      DateTime dateTime = DateTime(homeAccountList!.pickerYear, i, 1);
      final backgroundColor = dateTime.isAtSameMomentAs(homeAccountList!.selectedMonth)
          ? colorback
          : Colors.transparent;
      months.add(
        AnimatedSwitcher(
          duration: kThemeChangeDuration,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: TextButton(
            key: ValueKey(backgroundColor),
            onPressed: () {
              homeAccountList!.switchPickerMonth(i);
            },
            style: TextButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: CircleBorder(),
            ),
            child: Text(
              DateFormat('MMM').format(dateTime),
              style: TextStyle(fontSize: 17, color: colorFont),
            ),
          ),
        ),
      );
    }
    return months;
  }
  //
  List<Widget> generateMonths() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: generateRowOfMonths(1, 4),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: generateRowOfMonths(5, 8),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: generateRowOfMonths(9, 12),
      )
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(_onLayoutDone);
  }
  _onLayoutDone(_) {
    homeAccountList!.OutputVar();
  }

  @override
  Widget build(BuildContext context) {
    homeAccountList = Provider.of<HomeAccountList>(context);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: colorback,
          foregroundColor: colorFont,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                DateFormat('yyyy月MM').format(homeAccountList!.selectedMonth),
                style: TextStyle(fontSize: 20, color: colorFont),
              ),
              IconButton(
                  onPressed: homeAccountList!.switchPicker,
                  icon: Icon(Icons.arrow_drop_down)),
            ],
          )),
      drawer: Drawer(
        //清單
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              arrowColor: colorFont,
              decoration: BoxDecoration(
                color: Color.fromARGB(0xFF, 181, 215, 212),
              ),
              accountName: Text(
                "1",
                style: TextStyle(color: colorFont, fontSize: 20),
              ),
              //設定Email
              accountEmail: Text(
                "****@gmail.com",
                style: TextStyle(color: colorFont, fontSize: 20),
              ),
              //設定大頭照
              currentAccountPicture: CircleAvatar(
                //照片
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://image.freepik.com/free-photo/close-up-portrait-beautiful-cat_23-2149214373.jpg?w=1060'),
                backgroundColor: Colors.transparent,
              ),
              otherAccountsPictures: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SliverAppBarDemo()));
                  },
                ),
              ],
            ),
            ListTile(
              textColor: colorFont,
              leading: Icon(Icons.equalizer_rounded),
              title: Text('折線圖'),
              subtitle: Text('Line chart'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LineChart()));
                // Navigator.pushReplacementNamed(context, "/Line");
              },
            ),
            ListTile(
              textColor: colorFont,
              leading: Icon(Icons.settings),
              title: Text('功能設定'),
              subtitle: Text('Settings'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingPage()));
              },
            ),
            ListTile(
              textColor: colorFont,
              leading: Icon(Icons.mail),
              title: Text('備忘錄'),
              subtitle: Text('Memorandum'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => NotesPage()));
                // Navigator.pushReplacementNamed(context, "/note");
              },
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          Container(
            width: 100.w, // This will take 20% of the screen's width
            height: Adaptive.h(100),
            //主頁面/*雯坊*/
            child: Column(
              children: [
                Expanded(
                  //上頁面
                    flex: 9,
                    child: Row(
                      children: [
                        Container(
                          width: 20.w,
                          height: 100.h,
                          padding: EdgeInsets.only(top: 10),
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Text(
                                "支出\n" + "${homeAccountList!.p_n[1]}",
                                // "支出",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: 60.w, height: 100.h, child: OutcomeChart()),
                        Container(
                          width: 20.w,
                          height: 100.h,
                          padding: EdgeInsets.only(top: 10),
                          // color: Colors.black12,
                          alignment: Alignment.topCenter,

                          child: Column(
                            children: [
                              Text(
                                "收入\n" + "${homeAccountList!.p_n[0]}",
                                // "收入",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                Expanded(
                  //中頁面:內縮10要放一個清單在這裡
                    flex: 13,
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.all(10),
                      child: GroupedList(),
                    )),
              ],
            ),
          ),
          Container(
            width: 400, height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Theme.of(context).cardColor,
                  child: AnimatedSize(
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 300),
                    child: Container(
                      height: homeAccountList!.pickerOpen ? 300 : 0.0,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                // onPressed: homeAccountList!.switchPickerYear(-1),
                                onPressed: () {
                                  homeAccountList!.switchPickerYear(-1);
                                },
                                icon: Icon(Icons.navigate_before_rounded),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    homeAccountList!.pickerYear.toString(),
                                    style: TextStyle(fontSize: 20, color: colorFont),
                                  ),
                                ),
                              ),
                              IconButton(
                                // onPressed: homeAccountList!.switchPickerYear(1),
                                onPressed: () {
                                  homeAccountList!.switchPickerYear(1);
                                },
                                icon: Icon(Icons.navigate_next_rounded),
                              ),
                            ],
                          ),
                          ...generateMonths(),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      //Ting編輯
      floatingActionButton: FloatingActionButton(
        //浮動按鈕
        backgroundColor: Color.fromARGB(0xFF, 250, 175, 165),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AccountInputView()));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
