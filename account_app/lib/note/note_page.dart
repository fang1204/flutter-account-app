import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:account_app/note/notes_database.dart';
import 'package:account_app/note/note.dart';
import 'package:account_app/note/edit_note_page.dart';
import 'package:account_app/note/note_detail_page.dart';
import 'package:account_app/note/note_card_widget.dart';
import 'package:flutter/services.dart';

Future notepage() async {

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

}

class NotesPage extends StatefulWidget {

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  Future<bool?> showWarning(BuildContext context) async=> showDialog<bool>(
    context:  context,
    builder: (context) =>AlertDialog(
      title:Text("Do you want exit?"),
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
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) =>WillPopScope(
    onWillPop: ()async{
      final  shouldPop = await showWarning(context);
      return shouldPop ?? false;
    },
      child:Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(0xFF, 181, 215, 212),
      title: Text(
        'Notes',
        style: TextStyle(fontSize: 24),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.keyboard_arrow_left,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/home");
        },
      ),
    ),
    body: Center(
      child: isLoading
          ? CircularProgressIndicator()
          : notes.isEmpty
          ? Text(
        'No Notes',
        style: TextStyle(color: Colors.black, fontSize: 24),
      )
          : buildNotes(),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.black,
      child: Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddEditNotePage()),
        );

        refreshNotes();
      },
    ),
  ),);

  Widget buildNotes() => StaggeredGridView.countBuilder(
    padding: EdgeInsets.all(8),
    itemCount: notes.length,
    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final note = notes[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteDetailPage(noteId: note.id!),
          ));

          refreshNotes();
        },
        child: NoteCardWidget(note: note, index: index),
      );
    },
  );
}