// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../model/User.dart'; // Your User model
//
// class UserRepository {
//   final CollectionReference _usersCollection =
//   FirebaseFirestore.instance.collection('users');
//
//   // Find user by ID (changed from int to String for Firestore)
//   Future<User?> findById(String userId) async {
//     try {
//       DocumentSnapshot doc = await _usersCollection.doc(userId).get();
//       return doc.exists ? User.fromFirestore(doc) : null;
//
//     } catch (e) {
//       throw Exception('Error finding user: $e');
//     }
//   }
//
//   // Delete all users
//   Future<void> deleteAll() async {
//     try {
//       // Get all documents
//       QuerySnapshot snapshot = await _usersCollection.get();
//
//       // Delete in batch
//       WriteBatch batch = FirebaseFirestore.instance.batch();
//       for (DocumentSnapshot doc in snapshot.docs) {
//         batch.delete(doc.reference);
//       }
//       await batch.commit();
//     } catch (e) {
//       throw Exception('Error deleting all users: $e');
//     }
//   }
//
//   // Get all users
//   Future<List<User>> findAll() async {
//     try {
//       QuerySnapshot query = await _usersCollection.get();
//       return query.docs.map((doc) => User.fromFirestore(doc)).toList();
//     } catch (e) {
//       throw Exception('Error fetching users: $e');
//     }
//   }
//
//   // Save or update user
//   Future<User> save(User user) async {
//     try {
//       if (user.id == null) {
//         // New user - add to Firestore
//         DocumentReference docRef = await _usersCollection.add(user.toFirestore());
//         // Get the newly created document with ID
//         DocumentSnapshot doc = await docRef.get();
//         return User.fromFirestore(doc);
//       } else {
//         // Existing user - update
//         await _usersCollection.doc(user.id).update(user.toFirestore());
//         return user;
//       }
//     } catch (e) {
//       throw Exception('Error saving user: $e');
//     }
//   }
//
//   // Delete by ID
//   Future<void> deleteAccountById(String id) async {
//     try {
//       await _usersCollection.doc(id).delete();
//     } catch (e) {
//       throw Exception('Error deleting user: $e');
//     }
//   }
//
//   // Delete by username and password
//   Future<void> deleteAccountByUsernameAndPassword(
//       String username, String password) async {
//     try {
//       QuerySnapshot query = await _usersCollection
//           .where('username', isEqualTo: username)
//           .where('password', isEqualTo: password)
//           .get();
//
//       if (query.docs.isEmpty) {
//         throw Exception('User not found or credentials invalid');
//       }
//
//       await query.docs.first.reference.delete();
//     } catch (e) {
//       throw Exception('Error deleting user: $e');
//     }
//   }
//
//   // Find by username
//   Future<User?> findByUsername(String username) async {
//     try {
//       QuerySnapshot query = await _usersCollection
//           .where('username', isEqualTo: username)
//           .limit(1)
//           .get();
//
//       return query.docs.isNotEmpty
//           ? User.fromFirestore(query.docs.first)
//           : null;
//     } catch (e) {
//       throw Exception('Error finding user by username: $e');
//     }
//   }
//
//   // Find by username and password
//   Future<User?> findByUsernameAndPassword(
//       String username, String password) async {
//     try {
//       QuerySnapshot query = await _usersCollection
//           .where('username', isEqualTo: username)
//           .where('password', isEqualTo: password)
//           .limit(1)
//           .get();
//
//       return query.docs.isNotEmpty
//           ? User.fromFirestore(query.docs.first)
//           : null;
//     } catch (e) {
//       throw Exception('Error finding user by credentials: $e');
//     }
//   }
// }