import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';


enum LoginStateModel{IDLE, LOADING, SUCCESS, FAIL}

class UserModel extends Model{

  final googleSignIn = GoogleSignIn();
  final auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic>  userData = Map();
  final facebookLogin = FacebookLogin();

  final _stateController = BehaviorSubject<LoginStateModel>();
  Stream<LoginStateModel> get outState => _stateController.stream;
  StreamSubscription _streamSubscription;

  UserModel(){
    _streamSubscription = auth.onAuthStateChanged.listen((user){
      if(user != null){
        _stateController.add(LoginStateModel.SUCCESS);
      }else{
        _stateController.add(LoginStateModel.IDLE);
      }
    });
  }


/*
  Future signUp({@required String email, @required String password}) async {

    isLoading =true;
    notifyListeners();
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    isLoading = false;
    notifyListeners();
  }*/



  void signOut() async{
    _stateController.add(LoginStateModel.LOADING);
    await auth.signOut();
    firebaseUser = null;
    userData = Map();
    _stateController.add(LoginStateModel.IDLE);
    notifyListeners();

  }


  Future<Null> signInGoogle() async {
    _stateController.add(LoginStateModel.LOADING);
    notifyListeners();
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
    await auth.signInWithCredential(credential).then((user){
      firebaseUser = user.user;
      _stateController.add(LoginStateModel.SUCCESS);
      notifyListeners();
    }).catchError((e){
      _stateController.add(LoginStateModel.FAIL);
      notifyListeners();
    });


  }

  Future signInFacebook() async {
    _stateController.add(LoginStateModel.LOADING);
    notifyListeners();
    final result = await facebookLogin.logIn(['email']);

    if(result.status == FacebookLoginStatus.loggedIn){
      final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
      await auth.signInWithCredential(credential).then((user){
        firebaseUser = user.user;
        _stateController.add(LoginStateModel.SUCCESS);
        notifyListeners();
      }).catchError((e){
        _stateController.add(LoginStateModel.FAIL);
        notifyListeners();
      });

    }
  }
//email and password
  Future signInWithEmailAndPass({@required String email, @required String password}) async {
    _stateController.add(LoginStateModel.LOADING);
    notifyListeners();
    await auth.signInWithEmailAndPassword(email: email, password: password).then((auth){
      firebaseUser = auth.user;
      _stateController.add(LoginStateModel.SUCCESS);
      notifyListeners();
    }).catchError((e){
      _stateController.add(LoginStateModel.FAIL);
      notifyListeners();
    });

  }

  @override
  void dispose() {
    _stateController.close();
    _streamSubscription.cancel();

  }
}