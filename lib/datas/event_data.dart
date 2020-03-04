import 'package:cloud_firestore/cloud_firestore.dart';

class EventData {
  String eid;
  String cid;
  DateTime dateEvent;
  String typeEvent;
  String nameEvent;
  String localeEvent;
  String descriptionEvent;
  String image;

  EventData();

  EventData.fromDocument(DocumentSnapshot document) {
    eid = document.documentID;
    cid = document.data["cid"];
    nameEvent = document.data["nameEvent"];
    typeEvent = document.data["typeEvent"];
    dateEvent = document.data["dateEvent"].toDate();
    localeEvent = document.data["localeEvent"];
    descriptionEvent = document.data["descriptionEvent"];
    image = document.data["image"];
  }

  Map<String, dynamic> toMap() {
    return {
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
