import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final db = FirebaseFirestore.instance;
  List<Task> tasks = [];

  // load task on init state
  Future<void> load(String name) async {
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

  Future<void> add(String name) async {
    try {
      if (name.trim().isNotEmpty) {
        
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}