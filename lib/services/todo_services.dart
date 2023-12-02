import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_api/models/todo_model.dart';

class TodoApiServices {
  final url = 'https://65603d6483aba11d99d0722c.mockapi.io/Notes';

  final Dio dio = Dio();

  Future<List<TodoModel>> getTodo() async {
    final Response<List<dynamic>> res = await dio.get(url);

    try {
      if (res.statusCode == 200) {
        final List<dynamic> data = res.data ?? [];
        return data.map((item) {
          return TodoModel.fromJson(item);
        }).toList();
      } else {
        throw Exception('failed');
      }
    } catch (e) {
      throw Exception('failed $e');
    }
  }

  createTodo(TodoModel value) async {
    try {
      await dio.post(url, data: value.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  deleteTodo({required id}) async {
    final dlturl = 'https://65603d6483aba11d99d0722c.mockapi.io/Notes/$id';

    try {
      await dio.delete(dlturl);
    } catch (e) {
      throw Exception(e);
    }
  }

  updateTodo({required id, required TodoModel value}) async {
    final editurl = 'https://65603d6483aba11d99d0722c.mockapi.io/Notes/$id';
    try {
      await dio.put(editurl, data: value.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
