import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Firestore _firestore = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  bool loading = false;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String password,
      @required VoidCallback onSuccess,
      @required Function onFailure}) async {
    loading = true;
    notifyListeners();

    try {
      QuerySnapshot query = await _firestore
          .collection("users")
          .where("email", isEqualTo: userData["email"])
          .getDocuments();

      if (query.documents.toList().length > 0) {
        onFailure('Já existe uma conta com esse e-mail!');
      }

      AuthResult user = await _auth.createUserWithEmailAndPassword(
          email: userData["email"], password: password);
      firebaseUser = user.user;

      await _saveUserData(userData);

      onSuccess();
      loading = false;
      notifyListeners();
    } catch (e) {
      onFailure('Erro ao cadastrar seus dados.');
      loading = false;
      notifyListeners();
    }
  }

  void signIn(
      {@required String email,
      @required String password,
      @required VoidCallback onSuccess,
      @required Function onFailure}) async {
    loading = true;
    notifyListeners();

    try {
      AuthResult user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      firebaseUser = user.user;

      await _loadCurrentUser();

      onSuccess();
      loading = false;
      notifyListeners();
    } catch (e) {
      onFailure(
          'Falha ao realizar o login. Verifique seus dados!' + e.toString());
      loading = false;
      notifyListeners();
    }
  }

  Future<Null> signGoogle(
      {@required VoidCallback onSuccess, @required Function onFailure}) async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final AuthResult user = await _auth.signInWithCredential(credential);
      firebaseUser = user.user;

      QuerySnapshot snapshot = await _firestore
          .collection("users")
          .where("email", isEqualTo: googleSignInAccount.email)
          .getDocuments();
      if (snapshot.documents.length > 0) {
        DocumentSnapshot doc = snapshot.documents.first;

        this.userData = doc.data;
      } else {
        Map<String, dynamic> userData = {
          "displayName": googleSignInAccount.displayName,
          "email": googleSignInAccount.email,
          "date_nasc": "",
          "type_blood": "",
          "photoUrl": googleSignInAccount.photoUrl
        };
        this.userData = userData;

        await _firestore
            .collection("users")
            .document(firebaseUser.uid)
            .setData(userData);
      }

      onSuccess();
      loading = false;
      notifyListeners();
    } catch (e) {
      onFailure(e.toString());
      loading = false;
      notifyListeners();
    }
  }

  Future<Null> signFacebook(
      {@required VoidCallback onSuccess, @required Function onFailure}) async {
    loading = true;
    notifyListeners();
    try {
      final facebookLogin = FacebookLogin();
      final FacebookLoginResult facebookLoginResult =
          await facebookLogin.logIn(['email']);

      switch (facebookLoginResult.status) {
        case FacebookLoginStatus.error:
          onFailure('Erro para logar no facebook!');
          break;
        case FacebookLoginStatus.cancelledByUser:
          onFailure('Cancelado pelo usuário!');
          break;
        case FacebookLoginStatus.loggedIn:
          final AuthCredential credential = FacebookAuthProvider.getCredential(
              accessToken: facebookLoginResult.accessToken.token);
          final AuthResult user = await _auth.signInWithCredential(credential);
          firebaseUser = user.user;
          onSuccess();
          break;
      }

      loading = false;
      notifyListeners();
    } catch (e) {
      onFailure();
      loading = false;
      notifyListeners();
    }
  }

  void recoveryPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  void signOut() async {
    await _auth.signOut();
    firebaseUser = null;
    userData = Map();

    notifyListeners();
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;

    await _firestore
        .collection("users")
        .document(firebaseUser.uid)
        .setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) {
      firebaseUser = await _auth.currentUser();
    }

    if (userData["displayName"] == null) {
      DocumentSnapshot doc =
          await _firestore.collection("users").document(firebaseUser.uid).get();
      userData = doc.data;
    }

    notifyListeners();
  }
}
