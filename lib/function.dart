import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

String formatName(String name){
  List<int> capitalLettersIndex=[];
  for(int i=0;i<name.length;i++){
    if(name[i]==" "){
      capitalLettersIndex.add(i);
    }
  }
  for(int i=0;i<capitalLettersIndex.length;i++){
    String smallLetter = name.substring(
        capitalLettersIndex[i],capitalLettersIndex[i]+2);
    String capitalLetter = smallLetter.toUpperCase();
    name = name.replaceRange(
        capitalLettersIndex[i],
        capitalLettersIndex[i]+2,
        capitalLetter
    );
  }
  String firstLetter = name[0];
  name = name.replaceFirst(firstLetter, firstLetter.toUpperCase());
  return name;
}

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<UserCredential> signInWithFacebook() async {
  final LoginResult loginResult = await FacebookAuth.instance.login();

  final OAuthCredential facebookAuthCredential =
  FacebookAuthProvider.credential(loginResult.accessToken!.token);

  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}

Future<void> logOut()async{
  await FirebaseAuth.instance.signOut();
  print("SIGN OUT");
}

void createUser({
  @required String? uId,
  @required String? name,
  @required String? profilePic,
  @required String? email,
  @required String? phoneNumber,
}){
  FirebaseFirestore.instance.collection('users')
      .doc(uId)
      .set({
    "bio":"bio...",
    "cover":"https://blogs.travelportalsolution.com/wp-content/uploads/2019/12/default_cover.jpg",
    "profile":profilePic,
    "email":email,
    "phone":phoneNumber??"",
    "name":name,
    "uId":uId,
  }).then((value) {
    print('USER CREATED');
    print(name);
  }).catchError((error){
    print('createUser error');
  });
}

void createUserFromGoogle()async{
  await signInWithGoogle().then((value){
    var user = value.user;
    String name = formatName(user!.displayName!);
    createUser(
        uId: user.uid,
        name: name,
        profilePic: user.photoURL,
        email: user.email,
        phoneNumber: user.phoneNumber
    );
  }).catchError((error){
    print('createUser error');
  });
}

void createUserFromFacebook()async{
  await signInWithFacebook().then((value){
    var user = value.user;
    String name = formatName(user!.displayName!);
    createUser(
        uId: user.uid,
        name: name,
        profilePic: user.photoURL,
        email: user.email,
        phoneNumber: user.phoneNumber
    );
  }).catchError((error){
    print('createUser error');
  });
}

