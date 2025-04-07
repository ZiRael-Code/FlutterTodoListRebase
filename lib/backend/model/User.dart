// import 'ToDoItem.dart';
//
// class User {
//   final String? id;
//   final String email;
//   final String username;
//   final String password;
//   final bool enabled;
//   final List<ToDoItem> myTasks;
//   final List<Map<String, String>> taskCategory;
//
//   User({
//     this.id,
//     required this.email,
//     required this.username,
//     required this.password,
//     this.enabled = false,
//     List<ToDoItem>? myTasks,
//     List<Map<String, String>>? taskCategory,
//   })  : myTasks = myTasks ?? [],
//         taskCategory = taskCategory ?? [];
//
//   // Method to update user fields (instead of copyWith)
//   User update({
//     String? email,
//     String? username,
//     String? password,
//     bool? enabled,
//     List<ToDoItem>? myTasks,
//     List<Map<String, String>>? taskCategory,
//   }) {
//     return User(
//       id: id,
//       email: email ?? this.email,
//       username: username ?? this.username,
//       password: password ?? this.password,
//       enabled: enabled ?? this.enabled,
//       myTasks: myTasks ?? this.myTasks,
//       taskCategory: taskCategory ?? this.taskCategory,
//     );
//   }
// }