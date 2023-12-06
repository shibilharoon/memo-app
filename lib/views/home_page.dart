import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notetaker/controllers/home_provider.dart';
import 'package:notetaker/services/api_services.dart';

import 'package:notetaker/views/edit_page.dart';
import 'package:notetaker/widgets/dialogue_box.dart';
import 'package:notetaker/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Memo',
          style: GoogleFonts.kanit(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) => FutureBuilder(
            future: ApiService().getNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemBuilder: (context, index) {
                    final data = homeProvider.noteList[index];
                    return Card(
                      elevation: 4,
                      color: const Color.fromARGB(255, 120, 10, 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 0.001,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        title: Text(
                                          'Title:',
                                          style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          data.title ?? 'data is here',
                                          style: GoogleFonts.quicksand(
                                              color: Colors.white),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          'Description:',
                                          style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          data.description ?? 'data is here',
                                          style: GoogleFonts.quicksand(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => EditPage(
                                            id: data.id!,
                                            title: data.title!,
                                            description: data.description!,
                                            onSave: () {
                                              homeProvider.loadNotes();
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child:
                                        const Icon(Icons.edit, color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () => showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text(
                                          'Are you sure to delete ?',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                homeProvider.deleteNote(
                                                    id: data.id);
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Confirm',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('No')),
                                        ],
                                      ),
                                    ),
                                    child:
                                        const Icon(Icons.delete, color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: homeProvider.noteList.length,
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const ShimmerLoader();
              } else {
                return const Center(child: Text('Data is not available'));
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const DialoguePage();
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 150, 14, 14),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
