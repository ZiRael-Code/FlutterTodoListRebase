// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBuemvEQAeJVeMcHN74vZJ3HumnjkWDaek',
    appId: '1:98819374221:web:f19103ea528f031096f6c4',
    messagingSenderId: '98819374221',
    projectId: 'todo-list-c11b5',
    authDomain: 'todo-list-c11b5.firebaseapp.com',
    storageBucket: 'todo-list-c11b5.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJChu3WEC-QepmTfkc1CEj7Z-veFldXg0',
    appId: '1:98819374221:android:037959163aff29bd96f6c4',
    messagingSenderId: '98819374221',
    projectId: 'todo-list-c11b5',
    storageBucket: 'todo-list-c11b5.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOzWYfhemfD2DVVVZ8kYTFSaDfqYpCNDc',
    appId: '1:98819374221:ios:af24734a7cd59ed896f6c4',
    messagingSenderId: '98819374221',
    projectId: 'todo-list-c11b5',
    storageBucket: 'todo-list-c11b5.firebasestorage.app',
    iosBundleId: 'com.example.todoListFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOzWYfhemfD2DVVVZ8kYTFSaDfqYpCNDc',
    appId: '1:98819374221:ios:af24734a7cd59ed896f6c4',
    messagingSenderId: '98819374221',
    projectId: 'todo-list-c11b5',
    storageBucket: 'todo-list-c11b5.firebasestorage.app',
    iosBundleId: 'com.example.todoListFlutter',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBuemvEQAeJVeMcHN74vZJ3HumnjkWDaek',
    appId: '1:98819374221:web:e69898ef863bbd3396f6c4',
    messagingSenderId: '98819374221',
    projectId: 'todo-list-c11b5',
    authDomain: 'todo-list-c11b5.firebaseapp.com',
    storageBucket: 'todo-list-c11b5.firebasestorage.app',
  );
}
