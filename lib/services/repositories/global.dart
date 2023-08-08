import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookley/models/main.dart';
import 'package:firebase_storage/firebase_storage.dart';

class _GlobalRepository {
  final FS = FirebaseFirestore.instance;

  Future getFoodTypes() {
    return FS.collection('foodTypes').get();
  }

  Future getTypeCusines() {
    return FS.collection('typeCusines').get();
  }

  Future<List> getFoodTypesAndTypeOfCusiness() {
    return Future.wait([
      getFoodTypes(),
      getTypeCusines(),
    ]);
  }
}

final globalRepository = _GlobalRepository();
