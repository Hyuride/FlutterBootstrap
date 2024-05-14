import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterbootstrap/services/firestore.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<StatefulWidget> createState() => _ToDoPageState();
  }

  class _ToDoPageState extends State<ToDoPage> {
    final FirestoreService firestoreService = FirestoreService();

    final TextEditingController textController = TextEditingController();

    void openNoteBox({String? docID}) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
                labelText: 'Add New To Do'
            )
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (docID == null) {
                    firestoreService.addNote(textController.text);
                  }
                  else {
                    firestoreService.updateNote(docID, textController.text);
                  }

                  textController.clear();
                  
                  Navigator.pop(context);
                },
                child: Text("Add"),
            )
          ],
        ),
      );
    }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.deepPurpleAccent,
              title: Text("To Do")),
          floatingActionButton: FloatingActionButton(
              onPressed: openNoteBox,
              child: const Icon(Icons.add)
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: firestoreService.getNotesStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List notesList = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: notesList.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = notesList[index];
                    String docID = document.id;

                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    String noteText = data['title'];

                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.deepPurpleAccent)
                          ),
                          child: ListTile(
                            title: Text(noteText),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => openNoteBox(docID: docID),
                                    icon: const Icon(Icons.settings),
                                  ),
                                  IconButton(
                                    onPressed: () => firestoreService.deleteNote(docID),
                                    icon: const Icon(Icons.delete),
                                  )
                                ]
                            ),
                          ),
                        ),
                    );
                  },
                );
              }
              else {
                return const Text("Loading List");
              }
            },
          )
        );
      }
    }