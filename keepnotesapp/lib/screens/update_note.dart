import 'package:flutter/material.dart';
import 'package:keepnotesapp/services/api_service.dart';

class UpdateNote extends StatefulWidget {
  final String id;
  final String title;
  final String content;
  const UpdateNote({Key? key, required this.id, required this.title, required this.content}) : super(key: key);

  @override
  _UpdateNoteState createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  final _updateNoteFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
      TextEditingController _titleController = TextEditingController(text: widget.title);
  TextEditingController _contentController = TextEditingController(text: widget.content);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _updateNoteFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Center(
                  child: Text(
                    "Edit Note",
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
                  // initialValue: widget.title,
                  decoration: const InputDecoration(
                    labelText: "Edit title",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 10),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  controller: _titleController,
                  // onChanged: (val) {
                  //   print(val);
                  //   setState(() {
                  //     _noteTitle = val;
                  //   });
                  // },
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
                  // initialValue: widget.content,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: _contentController,
                  // onChanged: (val) {
                  //   setState(() {
                  //     _noteContent = val;
                  //   });
                  // },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter Content.";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Edit content",
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
                    if (!_updateNoteFormKey.currentState!.validate()) ;
                    if (_titleController.text == "" || _contentController.text == "") {
                      return setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Inputs Can't be empty")));
                      });
                    } else {
                      ApiService().updateNoteWithId(
                        id: widget.id,
                        title: _titleController.text,
                        content: _contentController.text,
                        context: context
                      );
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
