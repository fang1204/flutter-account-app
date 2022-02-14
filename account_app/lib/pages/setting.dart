import "package:flutter/material.dart";
import 'package:account_app/pages/theme_option.dart';

enum SearchTypes {
  repos,
  users,
}
class SettingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
        ),
        title: Text("Setting"),
        backgroundColor: const Color.fromARGB(0xFF, 181, 215, 212),
      ),

      body: ListView(
        children: <Widget>[
          ExpansionTile(
            leading: Icon(Icons.palette),
            title: Text("顏色"),
            subtitle: Text('Color'),
            children: <Widget>[
              Wrap(
                spacing: 8.0,
                children: <Widget>[
                  ThemeOption(color: Colors.lightBlueAccent),
                ],
              )
            ],
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("語言"),
            subtitle: Text('Language '),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("繁體中文"),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.circle),
            title: Text("關於我們"),
            subtitle: Text('About me'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/about");
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("聯絡資訊"),
            subtitle: Text(' Contact Information'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
            onTap: () {
              showAlert(context);
            },
          ),
        ],
      ),
    );
  }
}

Future<void> showAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Mail'),
        content: const Text('. . . @gmail.com'),
        actions: <Widget>[
          FlatButton(
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
