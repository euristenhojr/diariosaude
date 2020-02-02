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
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  GoogleSignIn googleSignIn = GoogleSignIn();
  static final FacebookLogin facebookLogin = new FacebookLogin();
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  final _stateController = BehaviorSubject<LoginStateModel>();

  Stream<LoginStateModel> get outState => _stateController.stream;
  StreamSubscription _streamSubscription;

  UserModel() {
    _streamSubscription = auth.onAuthStateChanged.listen((user) {
      if (user != null) {
        firebaseUser = user;
        _stateController.add(LoginStateModel.SUCCESS);
        notifyListeners();
      } else {
        _stateController.add(LoginStateModel.IDLE);
      }
    });
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
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
    GoogleSignInAccount user = await googleSignIn.signIn();
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
    // _stateController.add(LoginStateModel.LOADING);
    // notifyListeners();
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        // _showMessage('');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.');
        // _showMessage('Something went wrong with the login process.\n'
        // 'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }

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
      {@required String email,
      @required String password,
      @required VoidCallback onSuccess,
      @required VoidCallback onFailure}) async {
    _stateController.add(LoginStateModel.LOADING);
    isLoading = true;
    notifyListeners();
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((auth) async {
      firebaseUser = auth.user;
      await _loadCurrentUser();

      _stateController.add(LoginStateModel.SUCCESS);
      notifyListeners();
      onSuccess();
    }).catchError((e) {
      _stateController.add(LoginStateModel.FAIL);
      notifyListeners();
      onFailure();
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

    if (firebaseUser != null && userData["displayName"] == null) {
      DocumentSnapshot docUser = await Firestore.instance
          .collection("users")
          .document(firebaseUser.uid)
          .get();

      userData = docUser.data;
    }

    notifyListeners();
  }
}
