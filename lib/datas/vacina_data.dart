import 'package:cloud_firestore/cloud_firestore.dart';

class VacinaData {
  String nomeVacina;
  String descricaoVacina;
  String idade;

  VacinaData();

  VacinaData.fromDocument(DocumentSnapshot document) {
    nomeVacina = document.data["nomeVacina"];
    descricaoVacina = document.data["descricaoVacina"];
    idade = document.data["idade"];
  }


}
