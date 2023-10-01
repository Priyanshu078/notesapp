import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/data/note.dart';

class ApiService {
  String baseUrl = "http://192.168.43.123:3000/api";
  final dio = Dio();

  Future<void> emptyTrash() async {
    String endPoint = '/emptyTrash';
    String url = baseUrl + endPoint;
    var response = await dio.post(url);
    debugPrint(response.toString());
  }

  Future<Map<String, List<Note>>> getNotes({
    required String userId,
    required bool trashed,
    required bool archived,
  }) async {
    String endPoint = '/getNotes';
    String url = baseUrl + endPoint;
    if (!trashed && !archived) {
      var response = await dio.post(url,
          data: {"userid": userId, "trashed": trashed, "archived": archived});
      List<Note> pinnedNotes = (response.data['pinned'] as List<dynamic>)
          .map((element) => Note.fromJson(element))
          .toList();
      List<Note> otherNotes = (response.data['others'] as List<dynamic>)
          .map((element) => Note.fromJson(element))
          .toList();
      return {
        "pinned": pinnedNotes,
        "others": otherNotes,
      };
    } else {
      List<Note> notes = [];
      debugPrint(userId);
      var response = await dio.post(url,
          data: {"userid": userId, "trashed": trashed, "archived": archived});
      List data = response.data;
      for (int i = 0; i < data.length; i++) {
        notes.add(
          Note(
            id: data[i]['id'],
            userid: data[i]['userid'],
            content: data[i]['content'],
            title: data[i]['title'],
            dateAdded: data[i]['dateAdded'].toString(),
            pinned: data[i]["pinned"],
            colorIndex: data[i]["colorIndex"],
            trashed: data[i]['trashed'],
            archived: data[i]['archived'],
          ),
        );
      }
      return {"notes": notes};
    }
  }

  Future<void> addNotes(Note note) async {
    String endPoint = '/addNotes';
    String url = baseUrl + endPoint;
    var response = await dio.post(url, data: {
      "id": note.id,
      "userid": note.userid,
      "title": note.title,
      "content": note.content,
      "pinned": note.pinned,
      "colorIndex": note.colorIndex,
      "trashed": note.trashed,
      "archived": note.archived,
      "dateAdded": note.dateAdded,
    });
    debugPrint(response.data.toString());
  }

  Future<void> deleteNotes(Note note) async {
    String endPoint = '/deleteNotes';
    String url = baseUrl + endPoint;
    var response = await dio.post(url, data: {
      "id": note.id,
      "dateAdded": DateTime.now().toString(),
    });
    debugPrint(response.data.toString());
  }

  Future<void> updateNotes(Note note) async {
    String endPoint = '/updateNotes';
    String url = baseUrl + endPoint;
    var response = await dio.post(url, data: {
      "id": note.id,
      "title": note.title,
      "content": note.content,
      "pinned": note.pinned,
      "colorIndex": note.colorIndex,
      "trashed": note.trashed,
      "archived": note.archived,
      "dateAdded": note.dateAdded,
    });
    debugPrint(response.data.toString());
  }
}
