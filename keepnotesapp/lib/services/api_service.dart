import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/note_model.dart';

class ApiService {
  Future<NotesModel> getNotes(context) async {
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
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something went wrong !")));
    }
    return _notesModel;
  }

  Future<Note> getNotesWithId(id, context) async {
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
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something went wrong !")));
    }
    return _note;
  }

  Future deleteNoteWithId(id, context) async {
    var client = http.Client();
    // ignore: avoid_init_to_null
    var _note = null;
    try {
      var response = await client
          .delete(Uri.parse("http://192.168.50.43:3500/api/keepNotes/$id"));
      if (response.statusCode == 200) {
        // print("successfully deleted!");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Successfully delted Note !")));
        // print(_jsonData);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("There is a problem while delting Note !")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something went wrong !")));
    }
    return _note;
  }

  Future addNote({
    title,
    content,
    context,
  }) async {
    var client = http.Client();
    // ignore: avoid_init_to_null
    var _note = null;
    try {
      var response = await client.post(
          Uri.parse("http://192.168.50.43:3500/api/keepNotes"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:
              jsonEncode(<String, String>{"title": title, "content": content}));
      if (response.statusCode == 200) {
        // print("successfully deleted!");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Successfully added Note !")));
        // print(_jsonData);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("There is a problem while adding Note !")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something went wrong !")));
    }
    return _note;
  }

  Future updateNoteWithId({
    required id,
    required title,
    required content,
    required context,
  }) async {
    var client = http.Client();
    // ignore: avoid_init_to_null
    var _note = null;
    try {
      var response = await client.put(
          Uri.parse("http://192.168.50.43:3500/api/keepNotes/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:
              jsonEncode(<String, String>{"title": title, "content": content}));
      if (response.statusCode == 200) {
        // print("successfully deleted!");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Successfully updated Note !")));
        // print(_jsonData);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("There is a problem while updating Note !")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something went wrong !")));
    }
    return _note;
  }
}
