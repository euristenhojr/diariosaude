import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:materno_infantil/datas/child_data.dart';
import 'package:materno_infantil/models/child_model.dart';
import 'package:materno_infantil/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class AddFilhos extends StatefulWidget {
  ChildData childData;
  AddFilhos(this.childData);
  @override
  _AddFilhosState createState() => _AddFilhosState(childData);
}

class _AddFilhosState extends State<AddFilhos> {

  ChildData childData;

  _AddFilhosState(this.childData);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _estaturaController = TextEditingController();
  final _tipoSanguineoController = TextEditingController();
  final _dateNasciController = TextEditingController();
  final _localNasciController = TextEditingController();

  final format = DateFormat("dd-MM-yyyy");

  @override
  void initState() {
    super.initState();
    if(childData.estatura != null){
      _pesoController.text = childData.peso.toString();
      _estaturaController.text = childData.estatura.toString();
      _tipoSanguineoController.text = childData.tipoSangue;
      _dateNasciController.text = childData.dataNasc;
      _localNasciController.text = childData.localNasc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return ScopedModelDescendant<ChildModel>(
          builder: (context, child, modelChild) {
        return Scaffold(
          key: _scaffoldKey,
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
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  childData.peso = double.tryParse(
                      _pesoController.text.replaceAll(",", "."));
                  childData.estatura = double.tryParse(
                      _estaturaController.text.replaceAll(",", "."));
                  childData.tipoSangue = _tipoSanguineoController.text;
                  childData.dataNasc = _dateNasciController.text;
                  childData.localNasc = _localNasciController.text;

                  bool result = await modelChild.updateChildData(childData);

                  if (result) {
                    _onSucess();
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => _pesoController.clear());
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => _estaturaController.clear());
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => _tipoSanguineoController.clear());
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => _dateNasciController.clear());
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => _localNasciController.clear());
                  }
                }
              },
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
                          image: NetworkImage(model.firebaseUser != null
                              ? model.firebaseUser.photoUrl
                              : "https://cdn.pixabay.com/photo/2016/02/04/13/49/the-earth-1179212_960_720.png"),
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
                                      image: NetworkImage(childData.image !=
                                              null
                                          ? childData.image
                                          : "https://cdn.pixabay.com/photo/2016/02/04/13/49/the-earth-1179212_960_720.png"),
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
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _pesoController,
                        style: TextStyle(fontSize: 14.0),
                        keyboardType: TextInputType.number,
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
                        controller: _estaturaController,
                        style: TextStyle(fontSize: 14.0),
                        keyboardType: TextInputType.number,
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
                        controller: _tipoSanguineoController,
                        style: TextStyle(fontSize: 14.0),
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
                      DateTimeField(
                        controller: _dateNasciController,
                        format: format,
                        validator: (dateNascimento) {
                          if (dateNascimento == null) {
                            return 'O campo Data de Nascimento é obrigatório';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Data de Nascimento",
                            suffixIcon: Icon(Icons.date_range)),
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? childData.dataNasc,
                            lastDate: DateTime(2100),
                          );
                        },
                      ),
                      TextFormField(
                        controller: _localNasciController,
                        style: TextStyle(fontSize: 14.0),
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
    });
  }

  void _onSucess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Dados Básicos Criado com Sucesso!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 1),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFailure(){

  }


}
