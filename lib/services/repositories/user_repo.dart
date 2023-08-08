import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookley/models/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

class _UserRepository {
  final _users = FirebaseFirestore.instance.collection('users');
  final _FA = FirebaseAuth.instance;
  final _FS = FirebaseStorage.instance;

  Future createUser(UserModel user) {
    String fileID = const Uuid().v4();
    user.avatar = fileID + '.png';

    final Map<String, dynamic> _user = user.toMap();
    _user['settings'] = user.settings.toMap();
    Timestamp createdAt = Timestamp.now();
    _user['created_at'] = createdAt;

    final storageRef = _FS.ref();
    //upload avatar;
    final mountainImagesRef = storageRef.child("user-avatars/${user.avatar}");
    mountainImagesRef.putString(
      user.avatar,
      format: PutStringFormat.base64,
      metadata: SettableMetadata(contentType: 'image/png'),
    );
    return _users.add(_user);
  }

  Future? getCurrentUser() {
    String? mobileNumber = _FA.currentUser!.phoneNumber;
    if (mobileNumber != null) {
      return _users
          .where('mobileNumber', isEqualTo: mobileNumber)
          .limit(1)
          .get();
    } else {
      return null;
    }
  }
}

final userRepository = _UserRepository();
