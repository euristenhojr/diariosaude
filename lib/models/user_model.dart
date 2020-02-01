import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

enum LoginStateModel { IDLE, LOADING, SUCCESS, FAIL }

class UserModel extends Model {
  final googleSignIn = GoogleSignIn();
  final auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  final facebookLogin = FacebookLogin();

  bool isLoading = false;

  final _stateController = BehaviorSubject<LoginStateModel>();
  Stream<LoginStateModel> get outState => _stateController.stream;
  StreamSubscription _streamSubscription;

  UserModel() {
    _streamSubscription = auth.onAuthStateChanged.listen((user) {
      if (user != null) {
        _stateController.add(LoginStateModel.SUCCESS);
      } else {
        _stateController.add(LoginStateModel.IDLE);
      }
    });
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFailure}) {
    isLoading = true;
    notifyListeners();

    auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user) async {
      firebaseUser = user.user;

      await _saveUserData(userData);

      onSuccess();

      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFailure();
      isLoading = false;
      notifyListeners();
    });
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;

    await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .setData(userData);
  }

  void signOut() async {
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
    if (user == null) {
      user = await googleSignIn.signInSilently();
    }
    if (user == null) {
      user = await googleSignIn.signIn();
    }
    GoogleSignInAuthentication credentialsGoogle =
        await googleSignIn.currentUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: credentialsGoogle.idToken,
        accessToken: credentialsGoogle.accessToken);
    await auth.signInWithCredential(credential).then((user) {
      firebaseUser = user.user;
      _stateController.add(LoginStateModel.SUCCESS);
      notifyListeners();
    }).catchError((e) {
      _stateController.add(LoginStateModel.FAIL);
      notifyListeners();
    });
  }

  Future signInFacebook() async {
    _stateController.add(LoginStateModel.LOADING);
    notifyListeners();
    final result = await facebookLogin.logIn(['email']);

    if (result.status == FacebookLoginStatus.loggedIn) {
      final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token);
      await auth.signInWithCredential(credential).then((user) {
        firebaseUser = user.user;
        _stateController.add(LoginStateModel.SUCCESS);
        notifyListeners();
      }).catchError((e) {
        _stateController.add(LoginStateModel.FAIL);
        notifyListeners();
      });
    }
  }

//email and password
  Future signInWithEmailAndPass(
      {@required String email, @required String password}) async {
    _stateController.add(LoginStateModel.LOADING);
    notifyListeners();
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((auth) {
      firebaseUser = auth.user;
      _stateController.add(LoginStateModel.SUCCESS);
      notifyListeners();
    }).catchError((e) {
      _stateController.add(LoginStateModel.FAIL);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _stateController.close();
    _streamSubscription.cancel();
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) {
      firebaseUser = await auth.currentUser();
    }

    if (firebaseUser != null && userData["name"] == null) {
      DocumentSnapshot docUser = await Firestore.instance
          .collection("users")
          .document(firebaseUser.uid)
          .get();

      userData = docUser.data;
    }

    notifyListeners();
  }
}
