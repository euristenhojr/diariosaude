
import 'package:cloud_firestore/cloud_firestore.dart';

class ChildData{

  String cid;
  String nome;
  String userId;
  String image;


  ChildData();

  ChildData.fromDocument(DocumentSnapshot document){
    cid = document.documentID;
    nome = document.data["nome"];
    image = document.data["image"];
    userId = document.data["userId"];

  }

  Map<String, dynamic> toMap(){
    return{
      "nome": nome,
      "image": image,
      "userId": userId,
    };
  }

}