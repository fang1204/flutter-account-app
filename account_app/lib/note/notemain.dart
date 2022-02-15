import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:account_app/note/note_page.dart';



Future notepage() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(NotePage());
}

class NotePage extends StatelessWidget {
  static final String title = 'Notes SQLite';

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: title,
    themeMode: ThemeMode.dark,
    theme: ThemeData(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.blueGrey.shade900,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
    ),
    home: NotesPage(),
  );
}