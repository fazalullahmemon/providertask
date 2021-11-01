import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providertask/services/firebase_auth_services.dart';
import 'package:providertask/services/firebase_storage_service.dart';
import 'package:providertask/services/firestore_service.dart';
import 'package:providertask/services/image_picker_service.dart';

import 'auth_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
        Provider<ImagePickerService>(
          create: (_) => ImagePickerService(),
        ),
        Provider<FirebaseStorageService>(
          create: (_) => FirebaseStorageService(),
        ),
        Provider<FirestoreService>(
          create: (_) => FirestoreService(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: AuthWidget(),
      ),
    );
  }
}
