
import 'package:cloud_firestore/cloud_firestore.dart';

class EventData{

  String eid; // id do evento
  String cid; // id do filho
  String dateEvent;
  String typeEvent;
  String nameEvent;
  String localeEvent;
  String descriptionEvent;
  String image;


  EventData();

  EventData.fromDocument(DocumentSnapshot document){
    eid = document.documentID;
    cid = document.data["cid"];
    nameEvent = document.data["nameEvent"];
    typeEvent = document.data["typeEvent"];
    dateEvent = document.data["dateEvent"];
    localeEvent = document.data["localeEvent"];
    descriptionEvent = document.data["DescpritionEvent"];
    image = document.data["image"];

  }

  Map<String, dynamic> toMap(){
    return{
      "cid": cid,
      "nameEvent": nameEvent,
      "typeEvent": typeEvent,
      "dateEvent": dateEvent,
      "localeEvent": localeEvent,
      "descriptionEvent": descriptionEvent,
      "image": image,
    };
  }

}