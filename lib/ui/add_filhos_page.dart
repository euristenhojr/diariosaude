import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:materno_infantil/datas/child_data.dart';
import 'package:materno_infantil/models/user_model.dart';
import 'package:materno_infantil/ui/evento_calendario.dart';
import 'package:scoped_model/scoped_model.dart';

class AddFilhos extends StatelessWidget {
  final ChildData childData;

  AddFilhos(this.childData);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Dados Básicos",
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
            child: Icon(Icons.save),
            backgroundColor: Color.fromRGBO(0, 0, 153, 1)),
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
                        image: NetworkImage(model.userData["photoUrl"] != null
                            ? model.userData["photoUrl"]
                            : "https://www.maxfesta.com.br/imagens/produtos/28740/Detalhes/tnt-azul-marinho-metro.jpg"),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
                child: Container(
                  height: 17.0,
                  child: Text(
                    "${model.userData != null ? model.userData["displayName"] : ""}",
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
                                    image: NetworkImage(childData.image != null
                                        ? childData.image
                                        : "https://www.maxfesta.com.br/imagens/produtos/28740/Detalhes/tnt-azul-marinho-metro.jpg"),
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
                    ],
                  ),
                ),
              ),
              Form(
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(fontSize: 14.0),
                      obscureText: true,
                      validator: (peso) {
                        if (peso.isEmpty) {
                          return 'O campo Peso é obrigatório';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Peso",
                          suffixIcon: Icon(
                            Icons.lock_outline,
                            size: 20.0,
                          )),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 14.0),
                      obscureText: true,
                      validator: (estatura) {
                        if (estatura.isEmpty) {
                          return 'O campo Estatura é obrigatório';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Estatura",
                          suffixIcon: Icon(
                            Icons.lock_outline,
                            size: 20.0,
                          )),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 14.0),
                      obscureText: true,
                      validator: (bloodType) {
                        if (bloodType.isEmpty) {
                          return 'O campo Tipo Sanguíneo é obrigatório';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Tipo Sanguíneo",
                          suffixIcon: Icon(
                            Icons.lock_outline,
                            size: 20.0,
                          )),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 14.0),
                      obscureText: true,
                      validator: (dateNascimento) {
                        if (dateNascimento.isEmpty) {
                          return 'O campo Data de Nascimento é obrigatório';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Data de Nascimento",
                          suffixIcon: Icon(
                            Icons.lock_outline,
                            size: 20.0,
                          )),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 14.0),
                      obscureText: true,
                      validator: (localNascimento) {
                        if (localNascimento.isEmpty) {
                          return 'O campo Local de Nascimento é obrigatório';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Local de Nascimento",
                          suffixIcon: Icon(
                            Icons.lock_outline,
                            size: 20.0,
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
