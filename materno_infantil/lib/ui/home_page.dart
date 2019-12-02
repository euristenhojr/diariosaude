import 'package:flutter/material.dart';
import 'package:materno_infantil/ui/tela_cadastrar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'escolhaacoes_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _estaSelecionado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Diário Saúde",
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.child_care), onPressed: () {})
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20),
                child: Icon(Icons.person_outline,
                    size: 40.0, color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E)),
              ),
              Text(
                "Entre com",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0),
                textAlign: TextAlign.center,
              ),
              //Icon(MdiIcons.accountChild, size: 80.0,),
              //Icon(MdiIcons.babyFaceOutline, size: 80.0,),
              Container(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                        onPressed: () {},
                        child: Image.asset(
                          'images/logar-google.png',
                          height: 70.0,
                          width: 90.0,
                        )),
                    FlatButton(
                        onPressed: () {},
                        child: Image.asset(
                          'images/logar-facebook.png',
                          height: 70.0,
                          width: 90.0,
                        ))
                  ],
                ),
              ),
              Container(
                height: 45.0,
                child: Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Email: ",
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.grey)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                ),
              ),
              Container(
                height: 45.0,
                child: Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Senha: ",
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          size: 20.0,
                        ),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.grey)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                ),
              ),
              Container(
                height: 30.0,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      child: Checkbox(
                          value: _estaSelecionado,
                          onChanged: (bool valor) {
                            setState(() {
                              _estaSelecionado = valor;
                            });
                          }),
                    ),
                    Text("Lembrar Senha")
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: 5.0),
                child: Container(
                  height: 35.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => escolhaAcoes()));
                    },
                    child: Text("Entrar",
                        style: TextStyle(color: Colors.white, fontSize: 15.0)),
                    color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 20.0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TelaCadastrar()));
                        },
                        child: Text(
                          "Cadastrar",
                          style: TextStyle(
                              color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                              fontSize: 10.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20.0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Esqueci minha senha",
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
