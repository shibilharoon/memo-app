import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_api/models/todo_model.dart';
import 'package:todo_api/services/todo_services.dart';

class EditScreen extends StatefulWidget {
  String? title;
  String? description;
  String? id;
  EditScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.id});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  void initState() {
    title = TextEditingController(text: widget.title);
    description = TextEditingController(text: widget.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 15),
                child: IconButton(
                    onPressed: () {
                      updateTodo(id: widget.id);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
              const SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 40),
                child: TextFormField(
                  controller: title,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 143, 143, 143))),
                  style: GoogleFonts.poppins(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: TextFormField(
                  maxLines: 15,
                  controller: description,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 143, 143, 143))),
                  style: GoogleFonts.poppins(fontSize: 19),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateTodo({required id}) {
    final titleEdited = title.text;
    final descriptionEdited = description.text;
    TodoApiServices().updateTodo(
        id: id,
        value: TodoModel(description: descriptionEdited, title: titleEdited));
    Navigator.of(context).pop();
  }
}
