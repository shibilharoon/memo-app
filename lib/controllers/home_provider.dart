import 'package:flutter/material.dart';
import 'package:notetaker/models/model.dart';
import 'package:notetaker/services/api_services.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  List<NoteModel> noteList = [];
  void loadNotes() async {
    try {
      List<NoteModel> notes = await ApiService().getNotes();
      noteList = notes;
    } catch (error) {
      print('Error loading notes: $error');
    }
    notifyListeners();
  }

  addNotes(BuildContext context) async {
    final title = titlecontroller.text;
    final description = descriptioncontroller.text;
    await ApiService()
        .createNotes(NoteModel(description: description, title: title));
    loadNotes();
    Navigator.pop(context);

    notifyListeners();
  }
    deleteNote({required id}) async {
    await ApiService().deleteNotes(id: id);
    loadNotes();
    notifyListeners();
  }
    updateNotes({required id}){
    var titleEdit = titlecontroller.text;
    var descriptionEdit = descriptioncontroller.text;
    loadNotes();
    ApiService().editNotes(id: id,value: NoteModel(title: titleEdit,description: descriptionEdit));
    notifyListeners();
  }
}