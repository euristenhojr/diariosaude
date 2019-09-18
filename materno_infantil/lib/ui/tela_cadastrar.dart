import 'package:flutter/material.dart';
import 'package:materno_infantil/ui/home_page.dart';
import 'package:async/async.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class TelaCadastrar extends StatefulWidget {
  @override
  _TelaCadastrarState createState() => _TelaCadastrarState();
}

class _TelaCadastrarState extends State<TelaCadastrar> {
  String nome = "Cadastrar Usuário";

  String selecionado = null;

  final format = DateFormat("dd-MM-yyyy");

  List<DropdownMenuItem<String>> listDrop = [];

  void loadData() {
    listDrop = [];

    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo A+"),
      value: 'tipoA+',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo A-"),
      value: 'tipoA-',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo B+"),
      value: 'tipoB+',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo B-"),
      value: 'tipoB-',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo AB+"),
      value: 'tipoAB+',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo AB-"),
      value: 'tipoAB-',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo O+"),
      value: 'tipoO+',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo O-"),
      value: 'tipo0-',
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            nome ?? "Cadastrar Usuário",
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
                padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: GestureDetector(
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('images/personcadastro.png')),
                    ),
                  ),
                ),
              ),
              Container(
                height: 30.0,
                child: TextField(
                  style: TextStyle(fontSize: 14.0),
                  decoration: InputDecoration(
                      hintText: "Nome",
                      suffixIcon: Icon(
                        Icons.perm_contact_calendar,
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
                          hintText: "E-mail",
                          suffixIcon: Icon(
                            Icons.email,
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
                          hintText: "Senha",
                          suffixIcon: Icon(
                            Icons.lock_outline,
                            size: 20.0,
                          )),
                    ),
                  )),
              Container(
                height: 30.0,
                child: DateTimeField(
                  format: format,
                  decoration: InputDecoration(
                      hintText: "Data de Nascimento"),
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                        );
                  },
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: selecionado,
                  items: listDrop,
                  hint: Text(
                    "Tipo Sanguíneo",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  elevation: 0,
                  onChanged: (value) {
                    selecionado = value;
                    setState(() {});
                  },
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              ),
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
                    padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                    child:
                      Container(
                        height: 35,
                        width: 50,
                        child: Icon(Icons.photo_camera, color: Colors.white,),
                        color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                      ),
                    ),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                      child:
                      Container(
                        height: 35,
                        width: 50,
                        child: Icon(Icons.attach_file, color: Colors.white,),
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
