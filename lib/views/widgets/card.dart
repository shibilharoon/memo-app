import 'package:flutter/material.dart';
import 'package:todo_api/models/todo_model.dart';
import 'package:todo_api/services/todo_services.dart';
import 'package:todo_api/views/edit_page.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteCard extends StatefulWidget {
  AsyncSnapshot<List<TodoModel>> snapshot;
  NoteCard({
    required this.snapshot,
    super.key,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  List<TodoModel> todolist = [];
  @override
  void initState() {
    // TODO: implement initState
    if (widget.snapshot.hasData) {
      todolist = widget.snapshot.data!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: todolist.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final tododata = todolist[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditScreen(
                    description: tododata.description,
                    title: tododata.title,
                    id: tododata.id),
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 239, 159, 0),
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Text('Title',
                                  style: GoogleFonts.rubik(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(tododata.title!),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Description',
                                style: GoogleFonts.rubik(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(tododata.description!),
                            ),
                            const SizedBox(
                              height: 50,
                              width: 10,
                            ),
                          ]),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            deleteTodo(id: tododata.id);
                          },
                          icon: const Icon(Icons.delete, color: Colors.black))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  deleteTodo({required id}) {
    TodoApiServices().deleteTodo(id: id);
    setState(() {
      todolist.removeWhere((element) => element.id == id);
    });
  }
}
