import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:materno_infantil/datas/child_data.dart';
import 'package:materno_infantil/models/child_model.dart';
import 'package:materno_infantil/models/user_model.dart';
import 'package:materno_infantil/tile/child_tile.dart';
import 'package:scoped_model/scoped_model.dart';
import 'home_page.dart';

class CriarFilho extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CriarFilho> {
  final _nameController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _userModel = UserModel();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _userModel.outState.listen((state) {
      switch (state) {
        case LoginStateModel.FAIL:
          break;
        case LoginStateModel.IDLE:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
          break;
        case LoginStateModel.LOADING:
        case LoginStateModel.SUCCESS:
      }
    });
  }

  @override
  void dispose() {
    _userModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
        key: _scaffoldKey,
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
        body: ListView(children: <Widget>[
          Container(
              width: double.infinity,
              child: Column(children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Container(
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
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Olá, ${model.userData != null ? model.userData["displayName"] : ""}",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                )
              ])),
          SizedBox(
            height: 20.0,
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ScopedModelDescendant<ChildModel>(
                  builder: (context, child, modelChild) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Adicione a filho(a) a ser cuidado:",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          validator: (name) {
                            if (name.isEmpty) {
                              return "Digite o nome do Filho(a)!";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Digite o nome do filho(a)",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    ChildData childData = ChildData();
                                    childData.nome = _nameController.text;
                                    childData.userId = model.firebaseUser.uid;

                                    int tamanho =
                                        modelChild.listChildren.length;

                                    modelChild.addChildData(childData);

                                    if (tamanho !=
                                        modelChild.listChildren.length) {
                                      _onSucess();
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                              (_) => _nameController.clear());
                                    }
                                  }
                                },
                              ),
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(color: Colors.black)),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                      Column(
                        children: modelChild.listChildren.map((child) {
                          return Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 4.0),
                              child: ChildTile(child));
                        }).toList(),
                      ),
                    ]);
              }),
            ),
          ),
        ]),
      );
    });
  }

  void _onSucess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Filho Criado com Sucesso!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 1),
    ));
  }
}
