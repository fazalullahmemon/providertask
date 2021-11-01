import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providertask/common_widgets/avatar.dart';
import 'package:providertask/home/about_page.dart';
import 'package:providertask/models/avatar_reference.dart';
import 'package:providertask/services/firebase_auth_services.dart';
import 'package:providertask/services/firestore_service.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onAbout(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => AboutPage(),
      ),
    );
  }

  Future<void> _chooseAvatar(BuildContext context) async {
    try {
      // 1. Get image from picker
      // 2. Upload to storage
      // 3. Save url to Firestore
      // 4. (optional) delete local file as no longer needed
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.help),
          onPressed: () {},
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _signOut(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130.0),
          child: Column(
            children: <Widget>[
              _buildUserInfo(context: context),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo({required BuildContext context}) {
    final database = Provider.of<FirestoreService>(context, listen: false);
    final user = Provider.of<User>(context, listen: false);
    return StreamBuilder<AvatarReference>(
      stream: database.avatarReferenceStream(uid: user.uid),
      builder: (context, snapshot) {
        final avatarRef = snapshot.data;
        if (avatarRef != null) {
          return Avatar(
            photoUrl: avatarRef.downloadUrl,
            radius: 50,
            borderColor: Colors.black54,
            borderWidth: 2.0,
            onPressed: () => _chooseAvatar(context),
          );
        }
        return Avatar(
            photoUrl: '',
            radius: 50,
            borderColor: Colors.black54,
            borderWidth: 2.0,
            onPressed: () => _chooseAvatar(context));
      },
    );
    // TODO: Download and show avatar from Firebase storage
  }
}
