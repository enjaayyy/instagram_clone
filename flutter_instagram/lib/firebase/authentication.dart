import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_instagram/firebase/storage.dart';

class Authentication {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   Future<String> Signup ({
      required String email,
      required String password,
      required String username,
      required String description,
      required Uint8List file,
    }) async{
        String promp = "error";
        try {
          if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || description.isNotEmpty){
           UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
           print(credential.user!.uid);

           String storePhoto = await Storage().uploadImageToStorage('profilePics', file, false);

           await _firestore.collection('users').doc(credential.user!.uid).set({
            'username' : username,
            'uid' : credential.user!.uid,
            'email' : email,
            'description' : description,
            'followers' : [],
            'following' : [],
            'photoURL' : storePhoto,
           });
          
           promp = "success";
          }
        } catch(error) {
          promp = error.toString();
        }
        return promp;
    }

    Future<String> login({
      required String email,
      required String password
    }) async {
      String promp = 'Some error occured';

      try{
        if(email.isNotEmpty || password.isNotEmpty){
          await _auth.signInWithEmailAndPassword(email: email, password: password);
          promp = 'success';
        }else {
          promp = 'Please Enter All Information';
        }
      } catch(error){
        promp = error.toString();
      }
      return promp;
    }
}