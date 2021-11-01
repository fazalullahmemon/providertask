import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providertask/services/firebase_auth_services.dart';
import 'package:providertask/sign_in/sign_in_page.dart';

import 'home/home_page.dart';

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService authService = Provider.of(context, listen: false);
    return StreamBuilder<User>(
      stream: authService.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user != null) {
            return Provider<User>.value(
              value: user,
              child: HomePage(),
            );
          }
          return SignInPage();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
