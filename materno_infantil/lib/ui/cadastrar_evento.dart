import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//https://pub.dev/packages/datetime_picker_formfield#-example-tab-

class CadastrarEvento extends StatefulWidget {
  @override
  _CadastrarEventoState createState() => _CadastrarEventoState();
}

class _CadastrarEventoState extends State<CadastrarEvento> {
  String nome = "Cadastrar Evento";

  String selecionado = null;

  final format = DateFormat("dd-MM-yyyy");

  List<DropdownMenuItem<String>> listDrop = [];

  void loadData() {
    listDrop = [];

    listDrop.add(new DropdownMenuItem(
      child: new Text("Acompanhamento Médico"),
      value: 'AM',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Vacina"),
      value: 'vacina',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Rotina"),
      value: 'rotina',
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            nome ?? "Cadastrar Evento",
            style: TextStyle(fontSize: 14.0),
          ),
          backgroundColor: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.child_care), onPressed: () {})
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.save),
          backgroundColor: Color.fromARGB(0xFF, 0x1B, 0x30, 0xA1),
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
                            backgroundImage: ExactAssetImage(
                              'images/rosto1.jpg',
                            ),
                            minRadius: 15.0,
                            maxRadius: 20.0,
                          )),
                      Container(
                        width: 130,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Filha Angelina",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        margin: EdgeInsets.only(left: 25),
                        child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Container(
                              height: 35.0,
                              width: 35.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Color.fromARGB(0XFF, 0X32, 0X6B, 0X86)),
                              child: Icon(
                                Icons.edit,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: selecionado,
                  items: listDrop,
                  hint: Text(
                    "Tipo de Evento",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  elevation: 0,
                  onChanged: (value) {
                    selecionado = value;
                    setState(() {});
                  },
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                height: 30.0,
                child: TextField(
                  style: TextStyle(fontSize: 14.0),
                  decoration: InputDecoration(
                      hintText: "Data",
                      suffixIcon: Icon(
                        Icons.date_range,
                        size: 20.0,
                      )),
                  onChanged: (text) {
                    setState(() {
                      nome = text;
                    });
                  },
                ),
              ),
              Container(
                  height: 50.0,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: TextField(
                      style: TextStyle(fontSize: 14.0),
                      decoration: InputDecoration(
                          hintText: "Título do Evento",
                          suffixIcon: Icon(
                            Icons.title,
                            size: 20.0,
                          )),
                    ),
                  )),
              Container(
                  height: 50.0,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: TextField(
                      style: TextStyle(fontSize: 14.0),
                      decoration: InputDecoration(
                          hintText: "Adicionar Local",
                          suffixIcon: Icon(
                            Icons.location_on,
                            size: 20.0,
                          )),
                    ),
                  )),
              Container(
                  height: 50.0,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: TextFormField(
                      style: TextStyle(fontSize: 14.0),
                      decoration: InputDecoration(
                          hintText: "Adicionar uma Descrição",
                          suffixIcon: Icon(
                            Icons.assignment,
                            size: 20.0,
                          )),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  /*Padding(
                    padding: EdgeInsets.only(top: 0.0, bottom: 5.0),
                    child: Container(
                      height: 35.0,
                      width: 60.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => HomePage()));
                        },
                        child: Text("Criar",
                            style: TextStyle(color: Colors.white, fontSize: 12.0)),
                        color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                      ),
                    ),
                  ),*/
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, bottom: 5.0, top: 20.0),
                    child: Container(
                      height: 35,
                      width: 50,
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                      ),
                      color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, bottom: 5.0, top: 20.0),
                    child: Container(
                      height: 35,
                      width: 50,
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.white,
                      ),
                      color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
