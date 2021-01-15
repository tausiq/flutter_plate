import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plate/todo/todos_repository.dart';

import 'entities/entities.dart';
import 'model/models.dart';

class FirebaseTodosRepository implements TodosRepository {
  final todoCollection = FirebaseFirestore.instance.collection('todos');

  @override
  Future<void> addNewTodo(Todo todo) {
    return todoCollection.add(todo.toEntity().toDocument());
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    return todoCollection.doc(todo.id).delete();
  }

  @override
  Stream<List<Todo>> todos() {
    return todoCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Todo.fromEntity(TodoEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateTodo(Todo update) {
    return todoCollection.doc(update.id).update(update.toEntity().toDocument());
  }

  @override
  Future<Todo> getTodo(String id) {
    return todoCollection.doc(id).get().then((doc) {
      return Todo.fromEntity(TodoEntity.fromSnapshot(doc));
    });
  }
}
