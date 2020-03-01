import 'package:flutter/material.dart';
import 'package:materno_infantil/datas/child_data.dart';
import 'package:materno_infantil/datas/event_data.dart';
import 'package:intl/intl.dart';

class DescricaoEvento extends StatelessWidget {
  final EventData eventData;
  final ChildData childData;

  DescricaoEvento(this.eventData, this.childData);

  final format = DateFormat("dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cadastrar Evento",
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.child_care), onPressed: () {})
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 2.0, bottom: 20.0),
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(0xFF, 0xA9, 0xA9, 0xA9),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(childData.image != null
                                    ? childData.image
                                    : "https://www.maxfesta.com.br/imagens/produtos/28740/Detalhes/tnt-azul-marinho-metro.jpg"
                                ),
                                minRadius: 15.0,
                                maxRadius: 20.0,
                              )),
                          Container(
                            width: 130,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                childData.nome,
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text( "Data: ", style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 4.0),
                        child: Container(
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Text( format.format(eventData.dateEvent), style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),),
                        ),
                      ),
                      Text( "Tipo: ", style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 4.0),
                        child: Container(
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Text( eventData.typeEvent, style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),),
                        ),
                      ),
                      Text( "Nome: ", style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 4.0),
                        child: Container(
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Text( eventData.nameEvent, style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),),
                        ),
                      ),
                      Text( "Local: ", style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 4.0),
                        child: Container(
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Text( eventData.localeEvent, style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),),
                        ),
                      ),
                      Text( "Descrição: ", style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 4.0),
                        child: Container(
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Text( eventData.descriptionEvent, style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]   )
        )
    );
  }
}
