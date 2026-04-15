import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final db = FirebaseFirestore.instance;
  List<Task> tasks = [];

  // load task on init state
  Future<void> load() async {
    try {
      // database part where we load persisted tasks
      final snapshot = await db.collection('tasks').get();

      // update local state, or load tasks locally
      tasks = snapshot.docs.map((doc) => Task(
        id: doc.id,
        title: doc['title'] ?? '',
        completed: doc['completed'] ?? false,
      )).toList();
      notifyListeners();
    } catch(e) {
      print('Error: $e');
    }
  }

  Future<void> add(String title) async {
    try {
      if (title.trim().isEmpty) return;

      final ref = await db.collection('tasks').add({
        'title': title,
        'completed': false,
        'timestamp': FieldValue.serverTimestamp()
      });

      tasks.add(Task(id: ref.id, title: title, completed: false));
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> update(int i, bool completed) async {
    try {
      // update the database state using index ancd completed status
      await db.collection('tasks').doc(tasks[i].id).update({completed: completed});
      // update the local state using same details
      tasks[i] = Task(id: tasks[i].id, title: tasks[i].title, completed: completed);
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> delete(int i) async {
    try {
      // delete task from firestore using index
      await db.collection('tasks').doc(tasks[i].id).delete();
      // delete task from local task object using index
      tasks.removeAt(i);
      notifyListeners();
    } catch(e) {
      print('Error: $e');
    }
  }
}