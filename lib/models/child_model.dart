import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:materno_infantil/datas/child_data.dart';
import 'package:materno_infantil/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ChildModel extends Model {
  UserModel user;
  List<ChildData> listChildren = [];
  bool isLoading = false;

  UserModel userModel;

  ChildModel(this.user) {
    userModel = this.user;
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadChild();
  }

  Future<void> addChildData(ChildData f) async {
    listChildren.add(f);

    await Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("filhos")
        .add(f.toMap())
        .then((doc) {
      f.cid = doc.documentID;
    });

    notifyListeners();
  }

  Future<bool> updateChildData(ChildData f) async {
    await Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("filhos")
        .document(f.cid)
        .updateData(f.toMap())
        .catchError((e) {
      return false;
    });
    return true;
  }

  Future<void> removeChildData(ChildData f) async {
    await Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("filhos")
        .document(f.cid)
        .delete();

    listChildren.remove(f);
    notifyListeners();
  }

  Future<void> _loadChild() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("filhos")
        .getDocuments();
    listChildren =
        query.documents.map((doc) => ChildData.fromDocument(doc)).toList();
    notifyListeners();
  }
}
