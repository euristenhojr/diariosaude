import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:materno_infantil/datas/child_data.dart';
import 'package:materno_infantil/models/user_model.dart';
import 'package:materno_infantil/ui/add_filhos_page.dart';
import 'package:materno_infantil/ui/evento_calendario.dart';
import 'package:scoped_model/scoped_model.dart';

class EscolhaAcoes extends StatelessWidget {
  final ChildData childData;

  EscolhaAcoes(this.childData);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Diário Saúde",
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.child_care),
                onPressed: () {
                  model.signOut();
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(0xFF, 0x1B, 0x30, 0xA1)),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(model.firebaseUser != null
                            ? model.firebaseUser.photoUrl
                            : "https://www.maxfesta.com.br/imagens/produtos/28740/Detalhes/tnt-azul-marinho-metro.jpg"),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
                child: Container(
                  height: 17.0,
                  child: Text(
                    "${model.firebaseUser != null ? model.firebaseUser.displayName : ""}",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                child: Container(
                  height: 14.0,
                  child: Text("Fortaleza, 16 de Setembro de 2019",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10.0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                child: Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color.fromARGB(0xFF, 0xA9, 0xA9, 0xA9),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 30.0,
                              width: 30.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(//childData.image != null
                                        //? childData.image
                                         "https://www.maxfesta.com.br/imagens/produtos/28740/Detalhes/tnt-azul-marinho-metro.jpg"),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                "${childData.nome}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 5.0),
                          child: Container(
                            height: 35.0,
                            width: 35.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(0XFF, 0X32, 0X6B, 0X86)),
                            child: Icon(
                              Icons.edit,
                              size: 20.0,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color:
                                      Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E))),
                          child: SizedBox(
                            width: 14.0,
                            height: 14.0,
                            child: Icon(MdiIcons.accountCardDetails,
                                size: 50.0,
                                color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E)),
                          ),
                        ),
                        FlatButton(
                          padding: EdgeInsets.only(top: 3.0),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => AddFilhos(childData)));
                          },
                          child: Text(
                            "Dados Básicos",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventoCalendario()));
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    width: 2.0,
                                    color: Color.fromARGB(
                                        0xFF, 0x08, 0x4D, 0x6E))),
                            child: SizedBox(
                              width: 14.0,
                              height: 14.0,
                              child: Icon(MdiIcons.heartPulse,
                                  size: 50.0,
                                  color:
                                      Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E)),
                            ),
                          ),
                          Container(
                            height: 30.0,
                            width: 80.0,
                            padding: EdgeInsets.only(top: 3.0),
                            child: Text(
                              "Vacina",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 9.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color:
                                      Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E))),
                          child: SizedBox(
                            width: 14.0,
                            height: 14.0,
                            child: Icon(
                              Icons.assignment,
                              color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                              size: 50.0,
                            ),
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 80.0,
                          padding: EdgeInsets.only(top: 3.0),
                          child: Text(
                            "Rotina",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 9.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color:
                                      Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E))),
                          child: SizedBox(
                            width: 14.0,
                            height: 14.0,
                            child: Icon(MdiIcons.accountPlusOutline,
                                size: 50.0,
                                color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E)),
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 80.0,
                          padding: EdgeInsets.only(top: 3.0),
                          child: Text(
                            "Crescimento",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 9.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color:
                                      Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E))),
                          child: SizedBox(
                            width: 14.0,
                            height: 14.0,
                            child: Icon(MdiIcons.heart,
                                size: 50.0,
                                color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E)),
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 80.0,
                          padding: EdgeInsets.only(top: 3.0),
                          child: Text(
                            "Acompanhamento Médico",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 9.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color:
                                      Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E))),
                          child: SizedBox(
                            width: 14.0,
                            height: 14.0,
                            child: Icon(MdiIcons.accountChildCircle,
                                size: 50.0,
                                color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E)),
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 80.0,
                          padding: EdgeInsets.only(top: 3.0),
                          child: Text(
                            "Relatórios",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 9.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
