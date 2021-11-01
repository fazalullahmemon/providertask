import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:providertask/models/avatar_reference.dart';
import 'package:providertask/services/firestore_path.dart';

class FirestoreService {
  // Sets the avatar download url
  Future<void> setAvatarReference({
    required String uid,
    required AvatarReference avatarReference,
  }) async {
    final path = FirestorePath.avatar(uid);
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(avatarReference.toMap());
  }

  // Reads the current avatar download url
  Stream<AvatarReference> avatarReferenceStream({
    required String uid,
  }) {
    final path = FirestorePath.avatar(uid);
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();

    return snapshots.map((snapshot) {
      return AvatarReference.fromMap(snapshot.data()!);
    });
  }
}
