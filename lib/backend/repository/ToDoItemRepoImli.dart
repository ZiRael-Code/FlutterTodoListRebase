// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../model/ToDoItem.dart';
//
// class TodoItemRepository {
//   final CollectionReference<Map<String, dynamic>> _todosCollection =
//   FirebaseFirestore.instance
//       .collection('todos')
//       .withConverter<Map<String, dynamic>>(
//     fromFirestore: (snapshot, _) => snapshot.data()!,
//     toFirestore: (data, _) => data,
//   );
//
//   // Find task by ID
//   Future<ToDoItem?> findTask(String taskId, String userId) async {
//     try {
//       DocumentSnapshot<Map<String, dynamic>> doc =
//       await _todosCollection.doc(taskId).get();
//
//       if (doc.exists) {
//         final task = ToDoItem.fromFirestore(doc);
//         return task.userId == userId ? task : null;
//       }
//       return null;
//     } catch (e) {
//       throw Exception('Error finding task: $e');
//     }
//   }
//
//   // Save or update task
//   Future<ToDoItem> save(ToDoItem task) async {
//     try {
//       if (task.id == null) {
//         // New task - add to Firestore
//         DocumentReference<Map<String, dynamic>> docRef =
//         await _todosCollection.add(task.toFirestore());
//         // Get the newly created document with ID
//         DocumentSnapshot<Map<String, dynamic>> doc = await docRef.get();
//         return ToDoItem.fromFirestore(doc);
//       } else {
//         // Existing task - update
//         await _todosCollection.doc(task.id!).update(task.toFirestore());
//         return task;
//       }
//     } catch (e) {
//       throw Exception('Error saving task: $e');
//     }
//   }
//
//   // Delete all tasks for a user
//   Future<void> deleteAll(String userId) async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> query = await _todosCollection
//           .where('userId', isEqualTo: userId)
//           .get();
//
//       WriteBatch batch = FirebaseFirestore.instance.batch();
//       for (QueryDocumentSnapshot<Map<String, dynamic>> doc in query.docs) {
//         batch.delete(doc.reference);
//       }
//       await batch.commit();
//     } catch (e) {
//       throw Exception('Error deleting all tasks: $e');
//     }
//   }
//
//   // Alias for findTask
//   Future<ToDoItem?> findById(String taskId, String userId) async {
//     return findTask(taskId, userId);
//   }
//
//   // Get all tasks for a user
//   Future<List<ToDoItem>> findAllUserTask(String userId) async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> query = await _todosCollection
//           .where('userId', isEqualTo: userId)
//           .get();
//       return query.docs.map((doc) => ToDoItem.fromFirestore(doc)).toList();
//     } catch (e) {
//       throw Exception('Error fetching user tasks: $e');
//     }
//   }
//
//   // Get all tasks by priority
//   Future<List<ToDoItem>> findAllPriority(String userId, Priority priority) async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> query = await _todosCollection
//           .where('userId', isEqualTo: userId)
//           .where('priority', isEqualTo: priority.name)
//           .get();
//       return query.docs.map((doc) => ToDoItem.fromFirestore(doc)).toList();
//     } catch (e) {
//       throw Exception('Error fetching tasks by priority: $e');
//     }
//   }
//
//   // Delete specific task
//   Future<void> deleteTask(String userId, String todoItemId) async {
//     try {
//       final task = await findTask(todoItemId, userId);
//       if (task != null) {
//         await _todosCollection.doc(todoItemId).delete();
//       } else {
//         throw Exception('Task not found or does not belong to user');
//       }
//     } catch (e) {
//       throw Exception('Error deleting task: $e');
//     }
//   }
// }
