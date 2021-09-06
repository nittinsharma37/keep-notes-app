// To parse this JSON data, do
//
//     final notesModel = notesModelFromJson(jsonString);

import 'dart:convert';

class NotesModel {
    NotesModel({
        this.data,
    });

    List<Datum>? data;

    factory NotesModel.fromRawJson(String str) => NotesModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.id,
        required this.title,
        required this.content,
    });

    String id;
    String title;
    String content;


    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        title: json["title"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "content": content,
    };
}



/////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);


class Note {
    Note({
        required this.title,
        required this.content,
    });

    String title;
    String content;


    factory Note.fromRawJson(String str) => Note.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Note.fromJson(Map<String, dynamic> json) => Note(
        title: json["title"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {

        "title": title,
        "content": content,
    };
}
