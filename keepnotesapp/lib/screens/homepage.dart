import 'package:flutter/material.dart';
import 'package:keepnotesapp/model/note_model.dart';
import 'package:keepnotesapp/screens/add_note.dart';
import 'package:keepnotesapp/screens/note_screen.dart';
import 'package:keepnotesapp/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<NotesModel> _notesModel;

  @override
  void initState() {
    _notesModel = ApiService().getNotes(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NotesModel>(
      future: _notesModel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Notes App"),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NoteScreen(id: data.id)));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(data.title),
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNote()));
              },
              child: const Icon(Icons.add),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Notes App"),
              centerTitle: true,
            ),
            body: const Center(
            child: Text("Something went wrong!"),
          ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Notes App"),
              centerTitle: true,
            ),
            body: const Center(
            child: CircularProgressIndicator(),
          ),
          );
        }
      },
    );
  }
}
