import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:materno_infantil/datas/child_data.dart';
import 'package:materno_infantil/datas/event_data.dart';
import 'package:materno_infantil/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'child_model.dart';

class EventModel extends Model {

  UserModel user;
  ChildModel childModel;

  List<EventData> listEvents = [];
  List<EventData> listEventsFilter = [];
  //List<DateTime> date = [];
  bool isLoading = false;

  EventModel(this.user);


  Future<bool> addEventData(EventData f,) async {
    listEvents.add(f);

    await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("filhos")
        .document(f.cid)
        .collection("eventos")
        .add(f.toMap())
        .then((doc) {
      f.eid = doc.documentID;
    }).catchError((e){
      return false;
    });
    notifyListeners();
    return true;

  }


  Future<void> removeEventData(EventData f) async {
    await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("filhos")
        .document(f.cid)
        .collection("eventos")
        .document(f.eid)
        .delete();

    listEvents.remove(f);
    notifyListeners();
  }

  Future<void> loadEvents(ChildData childData) async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(childData.userId)
        .collection("filhos")
        .document(childData.cid)
        .collection("eventos")
        .getDocuments();
    listEvents =
        query.documents.map((doc) => EventData.fromDocument(doc)).toList();
    notifyListeners();
  }


  void listFilter(String data){
    listEventsFilter = listEvents;
    listEventsFilter = listEventsFilter.where((filter) => filter.dateEvent.compareTo(data) == 0).toList();
  }
  /*void loadDate(String data){
      DateTime dateTime = DateTime.parse(data);
      print(dateTime);
      date.add(dateTime);
  }*/

}
