import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_api/models/todo_model.dart';
import 'package:todo_api/services/todo_services.dart';
import 'package:todo_api/views/widgets/card.dart';
import 'package:todo_api/views/widgets/dialogue_box.dart';
import 'package:todo_api/views/widgets/loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    TodoApiServices().getTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Align(
          alignment: Alignment(.099, 0.99),
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return DialogBox(
                      titlecontroller: titlecontroller,
                      descriptioncontroller: descriptioncontroller);
                },
              );
            },
            backgroundColor: Color.fromARGB(255, 239, 159, 0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: const Icon(
              Icons.add,
              size: 35,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 50, left: 30),
                child: Text('Memo',
                    style: GoogleFonts.ubuntu(
                        fontSize: 25,
                        color: const Color.fromARGB(255, 239, 159, 0),
                        fontWeight: FontWeight.bold)),
              ),
              FutureBuilder<List<TodoModel>>(
                future: TodoApiServices().getTodo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ShimmerLoader();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.hasError.toString());
                  } else {
                    return Expanded(
                        child: NoteCard(
                      snapshot: snapshot,
                    ));
                  }
                },
              ),
            ],
          ),
        ));
  }
}
