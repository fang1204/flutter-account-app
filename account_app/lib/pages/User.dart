import "package:flutter/material.dart";

class SliverAppBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0xFF, 181, 215, 212),
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
        ),
        title: Text('User'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
        SliverAppBar(
        pinned: false,
        expandedHeight: 250.0,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.all(8.0),
          ),
          background: Image.network(
            "https://image.freepik.com/free-photo/close-up-portrait-beautiful-cat_23-2149214373.jpg?w=1060",
            fit: BoxFit.cover,
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (ctx, i)=> Card(
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title:Text("資料"),
                  onTap: (){
                    daata(context);
                  },
                )
            )
        ),
      )
        ],
      ),
    );
  }
}

Future<void> daata(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('資料'),
        content: const Text('使用者: Lab \n 電話:0123456789 \n 信箱. . .@gmail.com'),
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