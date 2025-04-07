// import '../service/UserService.dart';
//
// class ToDoItem {
//   final String? id;
//   final String title;
//   final String description;
//   final DateTime? dueDate;
//   final DateTime? startDate;
//   final String? taskStatus;
//   final String priority;
//   final bool completed;
//   final String userId;
//
//   ToDoItem(this.priority, {
//     this.id,
//     required this.title,
//     required this.description,
//     this.dueDate,
//     this.startDate,
//     this.taskStatus = UserService.taskStatusMap[""],
//     this.completed = false,
//     required this.userId,
//   });
//
//   // Method to update task fields (instead of copyWith)
//   ToDoItem update({
//     String? title,
//     String? description,
//     DateTime? dueDate,
//     DateTime? startDate,
//     TaskStatus? taskStatus,
//     Priority? priority,
//     bool? completed,
//     String? userId,
//   }) {
//     return ToDoItem(
//       id: id,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       dueDate: dueDate ?? this.dueDate,
//       startDate: startDate ?? this.startDate,
//       taskStatus: taskStatus ?? this.taskStatus,
//       priority: priority ?? this.priority,
//       completed: completed ?? this.completed,
//       userId: userId ?? this.userId,
//     );
//   }
// }