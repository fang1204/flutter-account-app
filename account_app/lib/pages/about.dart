import "package:flutter/material.dart";

enum SearchTypes {
  repos,
  users,
}
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);


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
            Navigator.pushReplacementNamed(context, "/setting");
          },
        ),
        title: Text('About me'),
      ),
      body: aboutme(),
    );
  }
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