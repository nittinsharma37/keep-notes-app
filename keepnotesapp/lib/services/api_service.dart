import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/note_model.dart';

class ApiService {
  Future<NotesModel> getNotes() async {
    var client = http.Client();
    // ignore: avoid_init_to_null
    var _notesModel = null;

    try {
      var response = await client
          .get(Uri.parse("http://192.168.50.43:3500/api/keepNotes"));
      if (response.statusCode == 200) {
        var _jsonData = response.body;
        var _jsonMap = jsonDecode(_jsonData);
        _notesModel = NotesModel.fromJson(_jsonMap);
      }
    } catch (e) {
      throw Exception("failed to load!");
    }
    return _notesModel;
  }

  Future<Note> getNotesWithId(id) async {
    var client = http.Client();
    // ignore: avoid_init_to_null
    var _note = null;
    try {
      var response = await client
          .get(Uri.parse("http://192.168.50.43:3500/api/keepNotes/$id"));
      if (response.statusCode == 200) {
        var _jsonData = response.body;
        // print(_jsonData);
        var _jsonMap = jsonDecode(_jsonData);
        _note = Note.fromJson(_jsonMap);
      }
    } catch (e) {
      throw Exception("failed to load!");
    }
    return _note;
  }
}
