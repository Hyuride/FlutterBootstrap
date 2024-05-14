import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final CollectionReference toDoList = FirebaseFirestore.instance.collection('toDoList');

  Future<void> addNote(String note) {
    return toDoList.add({
      'title': note,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        toDoList.orderBy('timestamp', descending: true).snapshots();

    return notesStream;
  }

  Future<void> updateNote(String docID, String newNote) {
    return toDoList.doc(docID).update({
      'title': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteNote(String docID) {
    return toDoList.doc(docID).delete();
  }
}