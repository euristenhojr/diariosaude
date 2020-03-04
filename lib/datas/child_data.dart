import 'package:cloud_firestore/cloud_firestore.dart';

class ChildData {
  String cid;
  String nome;
  String userId;
  String image;
  String dataNasc;
  String localNasc;
  double peso;
  double estatura;

  ChildData();

  ChildData.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    nome = document.data["nome"];
    image = document.data["image"];
    userId = document.data["userId"];
    dataNasc = document.data["dataNasc"];
    localNasc = document.data["localNasc"];
    peso = document.data["peso"];
    estatura = document.data["estatura"];
  }

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "image": image,
      "userId": userId,
      "dataNasc": dataNasc,
      "localNasc": localNasc,
      "peso": peso,
      "estatura": estatura,
    };
  }
}
