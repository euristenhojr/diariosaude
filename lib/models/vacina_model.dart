
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:materno_infantil/datas/vacina_data.dart';
import 'package:materno_infantil/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class VacinaModel extends Model {

  UserModel user;
  List<VacinaData> listVacinas = [];
  VacinaModel(this.user);




  Future<void> loadVacina() async {

    QuerySnapshot query = await Firestore.instance
        .collection("vacina")
        .getDocuments();
    listVacinas =
        query.documents.map((doc) => VacinaData.fromDocument(doc)).toList();

    notifyListeners();
  }
}