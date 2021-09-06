import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepnotesapp/model/note_model.dart';
import 'package:keepnotesapp/services/api_service.dart';

class NoteScreen extends StatefulWidget {
  final String id;
  const NoteScreen({Key? key, required this.id}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late Future<Note> _note;
  @override
  void initState() {
    super.initState();
    _note = ApiService().getNotesWithId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
      ),
      body: FutureBuilder<Note>(
        future: _note,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      data!.title,
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
    );
  }
}
