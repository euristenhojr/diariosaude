import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:materno_infantil/ui/escolhaacoes_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';


class UserModel extends Model{

  final googleSignIn = GoogleSignIn();
  final auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic>  userData = Map();
  final facebookLogin = FacebookLogin();

  bool isLoading = false;

/*
  Future signUp({@required String email, @required String password}) async {

    isLoading =true;
    notifyListeners();
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    isLoading = false;
    notifyListeners();
  }*/



  void signOut() async{
    await auth.signOut();
    firebaseUser = null;
    userData = Map();
    notifyListeners();
  }

  bool isLoggedIn(){
    return firebaseUser != null;
  }

  /*void mudarTela(){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => escolhaAcoes()));
  }*/

  Future<Null> signInGoogle() async {

    GoogleSignInAccount user = googleSignIn.currentUser;
    if(user == null) {
      user = await googleSignIn.signInSilently();
    }
    if(user == null){
      user = await googleSignIn.signIn();
    }
    GoogleSignInAuthentication credentialsGoogle = await googleSignIn.currentUser
          .authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: credentialsGoogle.idToken, accessToken: credentialsGoogle.accessToken);
    final AuthResult authResult = await auth.signInWithCredential(credential);
    firebaseUser = authResult.user;

  }

  Future signInFacebook() async {

    final result = await facebookLogin.logIn(['email']);
    print(result.status.toString());

    if(result.status == FacebookLoginStatus.loggedIn){
      final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
      final AuthResult authResult = await auth.signInWithCredential(credential);
      firebaseUser = authResult.user;
    }
  }
//email and password
  Future signInWithEmailAndPass({@required String email, @required String password}) async {
    isLoading = true;
    notifyListeners();

    final AuthResult authResult = await auth.signInWithEmailAndPassword(email: email, password: password).catchError((e){
      isLoading = false;
      notifyListeners();
    });

    if(authResult != null){
      firebaseUser = authResult.user;
    }
    isLoading = false;
    notifyListeners();

  }
}