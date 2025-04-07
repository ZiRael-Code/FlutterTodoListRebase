// import '../model/ToDoItem.dart';
// import '../model/User.dart';
// import '../repository/UserRepo.dart';
//
// class UserService {
//   final UserRepository _userRepository;
//
//   UserService({
//     required UserRepository userRepository,
//   }) : _userRepository = userRepository;
//
//   void _validateCreateRequest(Map<String, dynamic> request) {
//     if (request['username'] == null || request['password'] == null) {
//       throw Exception('Please input the required fields: Username, Password');
//     }
//   }
//   static const Map<String, String> taskTypeMap = {
//     'OFFICE_PROJECT': 'Office Project',
//     'DAILY_STUDIES': 'Daily Studies',
//     'PERSONAL_PROJECT': 'Personal Project',
//     'DAILY_ACTIVITY': 'Daily Activity',
//     'DAILY_TASK': 'Daily Task',
//     'BUHARI_TASK': 'Buhari Task',
//   };
//
//   /// Priorities as Key-Value Pairs
//   static const Map<String, String> priorityMap = {
//     'HIGH': 'High',
//     'MEDIUM': 'Medium',
//     'LOW': 'Low',
//   };
//   /// Priorities as Key-Value Pairs
//   static const Map<String, String> taskStatusMap = {
//     'HIGH': 'COMPLETED',
//     'MEDIUM': 'INPROGRESS',
//     'LOW': 'TODO',
//   };
//   Future<Map<String, dynamic>> createAccount(Map<String, dynamic> request) async {
//     _validateCreateRequest(request);
//
//     final taskCategories = [
//       {'typeName': 'OFFICE_PROJECT', 'color': null, 'icon': null},
//       {'typeName': 'DAILY_STUDIES', 'color': null, 'icon': null},
//       {'typeName': 'PERSONAL_PROJECT', 'color': null, 'icon': null},
//       {'typeName': 'DAILY_ACTIVITY', 'color': null, 'icon': null},
//       {'typeName': 'DAILY_TASK', 'color': null, 'icon': null},
//       {'typeName': 'BUHARI_TASK', 'color': null, 'icon': null},
//     ];
//
//     final user = User(
//       email: request['email']?.toString() ?? '',
//       password: request['password'].toString(),
//       username: request['username'].toString(),
//       taskCategory: taskCategories,
//     );
//
//     final savedUser = await _userRepository.save(user);
//
//     return {
//       'id': savedUser.id,
//       'email': savedUser.email,
//       'username': savedUser.username,
//     };
//   }
//
//   Future<Map<String, dynamic>> login(Map<String, dynamic> request) async {
//     final user = await _userRepository.findByUsernameAndPassword(
//       request['username'].toString(),
//       request['password'].toString(),
//     );
//
//     if (user == null) {
//       throw Exception('Username or password not correct');
//     }
//
//     // Update user using our new update method
//     final updatedUser = user.update(enabled: true);
//     await _userRepository.save(updatedUser);
//
//     return {
//       'id': user.id,
//       'email': user.email,
//       'username': user.username,
//       'message': 'Login Successful',
//       'loginStatus': true,
//     };
//   }
//
//   Future<Map<String, dynamic>> findByUsername(String username) async {
//     final user = await _userRepository.findByUsername(username);
//     if (user == null) throw Exception('User not found');
//
//     return {
//       'id': user.id,
//       'email': user.email,
//       'username': user.username,
//       'enabled': user.enabled,
//       'tasks': user.myTasks.map(_taskToMap).toList(),
//       'categories': user.taskCategory,
//     };
//   }
//
//   Map<String, dynamic> _taskToMap(ToDoItem task) {
//     return {
//       'id': task.id,
//       'title': task.title,
//       'description': task.description,
//       'dueDate': task.dueDate?.millisecondsSinceEpoch,
//       'startDate': task.startDate?.millisecondsSinceEpoch,
//       'status': task.taskStatus.toString(),
//       'priority': task.priority.toString(),
//       'completed': task.completed,
//     };
//   }
//
//   Future<void> logout(String username) async {
//     final user = await _userRepository.findByUsername(username);
//     if (user != null) {
//       await _userRepository.save(user.update(enabled: false));
//     }
//   }
//
//   Future<Map<String, dynamic>> findUserById(String userId) async {
//     final user = await _userRepository.findById(userId);
//     if (user == null) throw Exception('User not found');
//
//     // Update tasks using our new update method
//     final updatedTasks = user.myTasks.map((task) {
//       if (_checkIfCompleted(task)) {
//         return task.update(taskStatus: TaskStatus.completed);
//       } else if (_checkIfInProgress(task)) {
//         return task.update(taskStatus: TaskStatus.inProgress);
//       }
//       return task;
//     }).toList();
//
//     final updatedUser = await _userRepository.save(
//         user.update(myTasks: updatedTasks)
//     );
//
//     return {
//       'id': updatedUser.id,
//       'email': updatedUser.email,
//       'username': updatedUser.username,
//       'tasks': updatedUser.myTasks.map(_taskToMap).toList(),
//     };
//   }
//
//   bool _checkIfCompleted(ToDoItem task) {
//     return task.completed;
//   }
//
//   bool _checkIfInProgress(ToDoItem task) {
//     return task.dueDate?.isAfter(DateTime.now()) ?? false;
//   }
//
//   Future<void> deleteAccount(Map<String, dynamic> request) async {
//     _validateCreateRequest(request);
//     await _userRepository.deleteAccountByUsernameAndPassword(
//       request['username'].toString(),
//       request['password'].toString(),
//     );
//   }
//
//   Future<List<Map<String, dynamic>>> findAllUsers() async {
//     final users = await _userRepository.findAll();
//     return users.map((user) => {
//       'id': user.id,
//       'email': user.email,
//       'username': user.username,
//       'enabled': user.enabled,
//     }).toList();
//   }
// }