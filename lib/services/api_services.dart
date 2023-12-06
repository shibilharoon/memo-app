import 'package:dio/dio.dart';
import 'package:notetaker/models/model.dart';

class ApiService {
  Dio dio = Dio();
  var endpointUrl = 'https://656af722dac3630cf7278113.mockapi.io/memo';

  Future<List<NoteModel>> getNotes() async {
    try {
      Response response = await dio.get(endpointUrl);
      if (response.statusCode == 200) {
        var jsonList = response.data as List;
        List<NoteModel> notes = jsonList.map((json) {
          return NoteModel.fromJson(json);
        }).toList();

        return notes;
      } else {
        throw Exception('Failed to load notes');
      }
    } catch (error) {
      throw Exception('Failed to load notes: $error');
    }
  }

  createNotes(NoteModel value)async{
    try {
      await dio.post(endpointUrl,data: value.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
  deleteNotes({required id})async{
    var deleteUrl = 'https://656af722dac3630cf7278113.mockapi.io/memo/$id';
    try{
      await dio.delete(deleteUrl);
    }catch (e){
      throw Exception(e);
    }
  }
  editNotes({required NoteModel value,required id,})async{
    try{
      await dio.put('https://656af722dac3630cf7278113.mockapi.io/memo/$id',data: value.toJson());
    }catch (e){
      throw Exception(e);
    }
  }
}