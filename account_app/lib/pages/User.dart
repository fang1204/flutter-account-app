import "package:flutter/material.dart";
List list = [
  " 日 ",
  " 一 ",
  " 二 ",
  " 三 ",
  " 四 ",
  " 五 ",
  " 六 "
];

class SliverAppBarDemo extends StatelessWidget {
  // Future<bool?> showWarning(BuildContext context) async=> showDialog<bool>(
  //   context:  context,
  //   builder: (context) =>AlertDialog(
  //     title:Text("Do you want to exit?"),
  //     actions: [
  //       ElevatedButton(
  //         child: Text('No'),
  //         onPressed: () =>Navigator.pop(context,false),
  //       ),
  //       ElevatedButton(
  //         child: Text('Yes'),
  //         onPressed: () =>Navigator.pop(context,true),
  //       ),
  //     ],
  //   ),
  // );
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0xFF, 181, 215, 212),
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Color.fromARGB(0xff, 64, 102, 99),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('User',
          style: TextStyle(color: Color.fromARGB(0xff, 64, 102, 99)),
        ),

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
        ],
      ),
    );
  }
}


