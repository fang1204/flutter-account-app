import 'package:account_app/pages/setting.dart';
import "package:flutter/material.dart";

enum SearchTypes {
  repos,
  users,
}
class AboutPage extends StatelessWidget {
  Future<bool?> showWarning(BuildContext context) async=> showDialog<bool>(
    context:  context,
    builder: (context) =>AlertDialog(
      title:Text("Do you want to exit?"),
      actions: [
        ElevatedButton(
          child: Text('No'),
          onPressed: () =>Navigator.pop(context,false),
        ),
        ElevatedButton(
          child: Text('Yes'),
          onPressed: () =>Navigator.pop(context,true),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) =>WillPopScope(
    onWillPop: ()async{
      final  shouldPop = await showWarning(context);
      return shouldPop ?? false;
    },

      child:Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0xFF, 181, 215, 212),
        foregroundColor: Color.fromARGB(0xff, 64, 102, 99),
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
          ),
          onPressed: () {
            // Navigator.pushReplacementNamed(context, "/setting");
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context)=>SettingPage()));
          },
        ),
        title: Text('About me'),
      ),
      body: aboutme(),
    ),);
  }


class aboutme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Text(
          "第一批 \n 長榮大學",
          textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30)
        ),
      ),

        );
  }
}