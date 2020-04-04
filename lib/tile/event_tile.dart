import 'package:flutter/material.dart';
import 'package:materno_infantil/datas/child_data.dart';
import 'package:materno_infantil/datas/event_data.dart';
import 'package:materno_infantil/models/child_model.dart';
import 'package:materno_infantil/models/event_model.dart';
import 'package:materno_infantil/ui/descricao_event.dart';
import 'package:materno_infantil/ui/editar_evento.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';

class EventTile extends StatelessWidget {
  final EventData eventData;
  final ChildData childData;
  EventTile(this.eventData, this.childData);

  final format = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 50.0,
          width: 50.0,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(childData.image != null
                    ? childData.image
                    : "https://cdn.pixabay.com/photo/2016/02/04/13/49/the-earth-1179212_960_720.png"),
              )),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: ScopedModelDescendant<ChildModel>(
                builder: (context, child, model) {
              return ScopedModelDescendant<EventModel>(
                  builder: (context, child, modelEvent) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${childData.nome}",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${childData.localNasc != null ? childData.localNasc : ""}",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${eventData.typeEvent}",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        /*Text(
                              "${eventData.nameEvent}",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),*/
                        Text(
                          "${format.format(eventData.dateEvent)}",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.delete_forever),
                          color: Color.fromARGB(200, 184, 37, 45),
                          onPressed: () {
                            modelEvent.removeEventData(eventData);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Color.fromARGB(255, 184, 37, 45),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditarEvento(eventData, childData)));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          color: Color.fromARGB(255, 184, 37, 45),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    DescricaoEvento(eventData, childData)));
                          },
                        ),
                      ],
                    )
                  ],
                );
              });
            }),
          ),
        )
      ],
    );
  }
}
