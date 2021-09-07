import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepnotesapp/model/note_model.dart';
import 'package:keepnotesapp/screens/update_note.dart';
import 'package:keepnotesapp/services/api_service.dart';

class NoteScreen extends StatefulWidget {
  final String id;
  const NoteScreen({Key? key, required this.id}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late Future<Note> _note;
  final ApiService deleteNote = ApiService();
  String title = "";
  String content = "";


  _showDeleteDialog(BuildContext context, id) {
    AlertDialog alert = AlertDialog(
      title: const Text("Delete"),
      content: const Text("Are you sure to want to delete ?"),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Delete"),
          onPressed: () {
            deleteNote.deleteNoteWithId(id, context);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context){
        return alert;
      }
    );
  }

  @override
  void initState() {
    super.initState();
    _note = ApiService().getNotesWithId(widget.id, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _showDeleteDialog(context, widget.id);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: FutureBuilder<Note>(
        future: _note,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            title = data!.title;
            content = data.content;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      data.title,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        data.content,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      )),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong!"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateNote(
            id: widget.id,
            title: title,
            content: content,
          )));
        },
      ),
    );
  }
}
