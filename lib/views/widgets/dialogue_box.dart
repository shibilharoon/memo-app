import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_api/models/todo_model.dart';
import 'package:todo_api/services/todo_services.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({
    super.key,
    required this.titlecontroller,
    required this.descriptioncontroller,
  });

  final TextEditingController titlecontroller;
  final TextEditingController descriptioncontroller;

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 239, 159, 0),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Add Note',
                  style: GoogleFonts.rubik(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: widget.titlecontroller,
                decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: widget.descriptioncontroller,
                maxLines: 4,
                decoration: const InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        createNote();
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.black)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  createNote() {
    final title = widget.titlecontroller.text;
    final description = widget.descriptioncontroller.text;
    TodoApiServices()
        .createTodo(TodoModel(title: title, description: description));
    setState(() {
      TodoApiServices().getTodo();
    });
    widget.titlecontroller.clear();
    widget.descriptioncontroller.clear();
    Navigator.pop(context);
  }
}
