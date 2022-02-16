import 'package:account_app/data/home_account_list.dart';
import 'package:account_app/model/account.dart';
import 'package:account_app/utils/util.dart';
import 'package:account_app/widget/accountInput_view.dart';
import 'package:account_app/widget/card_view.dart';
import 'package:account_app/widget/groupedlist_view.dart';

import 'package:account_app/widget/list_view.dart';
import 'package:account_app/widget/pieCharts_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeAccountList? homeAccountList;
  final title = '測試';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(_onLayoutDone);
  }
  _onLayoutDone(_){
    homeAccountList!.OutputVar();
  }

  @override
  Widget build(BuildContext context) {
    homeAccountList = Provider.of<HomeAccountList>(context);

    return Scaffold(
      appBar: AppBar(
        //最上排
        title: Text('日期調整器'), //調整日期
        backgroundColor: const Color.fromARGB(0xFF, 181, 215, 212),

        /*標題列(清單、和日期)
        leading: IconButton(        //左滑清單

          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(               //+
            icon: Icon(Icons.add_circle),
            onPressed: () {},
          ),
          IconButton(               //右邊三點
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        */
      ),
      drawer: Drawer(
        //清單
        child: ListView(
          children:  <Widget>[
            UserAccountsDrawerHeader(
              onDetailsPressed:() {
                Navigator.pushReplacementNamed(context, "/user");
              },
              decoration: BoxDecoration(
                color: Color.fromARGB(0xFF, 181, 215, 212),
              ),
              accountName: Text("1",style: TextStyle(color: Colors.black87,fontSize: 18),),
              //設定Email
              accountEmail: Text("****@gmail.com",style: TextStyle(color: Colors.black87,fontSize: 15),),
              //設定大頭照
              currentAccountPicture: CircleAvatar(
                //照片
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://image.freepik.com/free-photo/close-up-portrait-beautiful-cat_23-2149214373.jpg?w=1060'),
                backgroundColor: Colors.transparent,
              ),
            ),
            ListTile(
              leading: Icon(Icons.equalizer_rounded),
              title: Text('折線圖'),
              subtitle: Text('Line chart'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/Line");
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('功能設定'),
              subtitle: Text('Settings'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/setting");
              },
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text('備忘錄'),
              subtitle: Text('Memorandum'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: (){
                Navigator.pushReplacementNamed(context, "/note");
              },
            ),
          ],
        ),
      ),

      body: Container(
        width:100.w,    // This will take 20% of the screen's width
        height: Adaptive.h(100),
        //主頁面/*雯坊*/
        child: (

          Consumer<HomeAccountList>(
            builder: (context, data, child){
              // data
              return Column(
                  children: [
                    Expanded(
                      //上頁面
                        flex: 9,
                        child: Row(
                          children: [
                            Expanded(
                              //上左:支出
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(right: 10, top: 10),
                                // color: Colors.black12,
                                alignment: Alignment.topCenter,
                                // child: Text(
                                //   '收入',
                                //   style: TextStyle(fontSize: 20),
                                // )
                                child: Column(
                                  children: [
                                    Text(
                                      "支出\n"+"${data.p_n[1]}",
                                      // "支出",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    // TextField(
                                    //   onChanged: (text) {
                                    //     print("支出:\n"+"${cal()[1]}");
                                    //   },
                                    // )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              //上中:結餘
                              flex: 7,
                              child: OutcomeChart(
                                // child: Text(
                                //   '結餘',
                                //   style: TextStyle(fontSize: 20),
                                // )
                              ),
                            ),
                            Expanded(
                              //上右:收入
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(right: 10, top: 10),
                                // color: Colors.black12,
                                alignment: Alignment.topCenter,
                                // child: Text(
                                //   '收入',
                                //   style: TextStyle(fontSize: 20),
                                // )
                                child: Column(
                                  children: [
                                    Text(
                                      "收入\n"+"${data.p_n[0]}",
                                      // "收入",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    // Text(
                                    //     "\n"+"${cal()[0]}"
                                    //   // onChanged: (text) {
                                    //   //   print("收入:\n"+"${cal()[0]}");
                                    //   // },
                                    // )
                                  ],
                                ),
                              )
                              ,
                            ),
                          ],
                        )),

                    Expanded(
                      //中頁面:內縮10要放一個清單在這裡
                        flex: 13,
                        child: Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.all(10),
                          // child: ListItem(),
                          child: ListItem(),
                          /*
                  child: ListView.builder(                 //主頁面

                    // itemCount: creditAccount.length,
                    itemCount: data.getCreditCardList().length,
                    itemBuilder: (context, position){
                      return CardView(
                          data.getCreditCardList()[position]
                      );


                    },

                  ),
                  */
                          // color: Colors.cyanAccent,
                          // child: Text(
                          //   '紀錄list',
                          //   textScaleFactor: 1,
                          //   style: TextStyle(fontSize: 20.0),
                          // ),
                        )
                    ),

                  ],
              );

            }

          )
        ),


      ),

      //Ting編輯
      floatingActionButton: FloatingActionButton(     //浮動按鈕
        backgroundColor: Color.fromARGB(0xFF, 250, 175, 165),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context)=>AccountInputView())).then((value) => homeAccountList!.OutputVar());
        },
        child: Icon(Icons.add),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );

  }
}