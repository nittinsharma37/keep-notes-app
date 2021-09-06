import 'package:flutter/material.dart';
import 'package:keepnotesapp/model/note_model.dart';
import 'package:keepnotesapp/screens/note_screen.dart';
import 'package:keepnotesapp/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<NotesModel> _notesModel;

  @override
  void initState() {
    _notesModel = ApiService().getNotes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
      ),
      body: FutureBuilder<NotesModel>(
        future: _notesModel,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index){
                var data = snapshot.data!.data![index];
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteScreen(id: data.id)));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(data.title),
                    ),
                  ),
                );
              },
            );
          }else if(snapshot.hasError){
            return const Center(
              child: Text("Something went wrong!"),
            );
          } else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}