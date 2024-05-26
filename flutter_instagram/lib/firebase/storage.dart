import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class Storage {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String name, Uint8List file, bool isPost) async {

   Reference ref = _storage.ref().child(name).child(_auth.currentUser!.uid);
   if(isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    
   UploadTask upload = ref.putData(file);
   
   TaskSnapshot snap = await upload;
   String download = await snap.ref.getDownloadURL();

   return download;

  }
}