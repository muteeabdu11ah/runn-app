// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB0imbGNMqi1DValYKEGXIgBjDB9g6hOa8',
    appId: '1:970647042884:web:35f271d0d171d3ce6fb511',
    messagingSenderId: '970647042884',
    projectId: 'rawoh-app',
    authDomain: 'rawoh-app.firebaseapp.com',
    storageBucket: 'rawoh-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBe3mH0j36tMpzSLbRyZQrIsS9Gy9VLFKc',
    appId: '1:970647042884:android:7af2eb8e9fa1b9be6fb511',
    messagingSenderId: '970647042884',
    projectId: 'rawoh-app',
    storageBucket: 'rawoh-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBKxapJ7ZFljGJn82oPVesVsOsukmfP0gQ',
    appId: '1:970647042884:ios:73ce61abc4ef3b1a6fb511',
    messagingSenderId: '970647042884',
    projectId: 'rawoh-app',
    storageBucket: 'rawoh-app.appspot.com',
    androidClientId: '970647042884-k30m8q0ib40vls0apg1h65pf9sejas18.apps.googleusercontent.com',
    iosClientId: '970647042884-8a56bslf0jeuvptmhikfhob5bi3iattk.apps.googleusercontent.com',
    iosBundleId: 'com.example.rawohSocial',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBKxapJ7ZFljGJn82oPVesVsOsukmfP0gQ',
    appId: '1:970647042884:ios:73ce61abc4ef3b1a6fb511',
    messagingSenderId: '970647042884',
    projectId: 'rawoh-app',
    storageBucket: 'rawoh-app.appspot.com',
    androidClientId: '970647042884-k30m8q0ib40vls0apg1h65pf9sejas18.apps.googleusercontent.com',
    iosClientId: '970647042884-8a56bslf0jeuvptmhikfhob5bi3iattk.apps.googleusercontent.com',
    iosBundleId: 'com.example.rawohSocial',
  );
}
