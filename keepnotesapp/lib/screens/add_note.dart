import 'package:flutter/material.dart';
import 'package:keepnotesapp/services/api_service.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _addNoteFormKey = GlobalKey<FormState>();
  String _noteTitle = "";
  String _noteContent = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addNoteFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Center(
                  child: Text(
                    "Add Note",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Add title",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 10),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (val) {
                    setState(() {
                      _noteTitle = val;
                    });
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter a title.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  onChanged: (val) {
                    setState(() {
                      _noteContent = val;
                    });
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter Content.";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Add content",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 10),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  child: const Text(
                    "Add Note",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    // ignore: empty_statements
                    if (!_addNoteFormKey.currentState!.validate()) ;
                    if (_noteTitle == "" || _noteContent == "") {
                      return setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Inputs Can't be empty")));
                      });
                    } else {
                      ApiService().addNote(
                          title: _noteTitle,
                          content: _noteContent,
                          context: context);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
