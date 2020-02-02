import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:materno_infantil/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:materno_infantil/ui/criar_filhos.dart';
import 'package:scoped_model/scoped_model.dart';

class TelaCadastrar extends StatefulWidget {
  @override
  _TelaCadastrarState createState() => _TelaCadastrarState();
}

class _TelaCadastrarState extends State<TelaCadastrar> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _dateNasciController = TextEditingController();

  String typeBlood;

  final format = DateFormat("dd-MM-yyyy");

  List<DropdownMenuItem<String>> listDrop = [];

  _TelaCadastrarState() {
    loadData();
  }

  void loadData() {
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
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Cadastrar'),
            centerTitle: true,
            backgroundColor: Color.fromRGBO(0, 91, 161, 1),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                Container(
                    width: 70.0,
                    height: 70.0,
                    child: Icon(
                      Icons.person_add,
                      size: 100,
                    )),
                SizedBox(
                  height: 35.0,
                ),
                TextFormField(
                    controller: _nameController,
                    style: TextStyle(fontSize: 14.0),
                    decoration: InputDecoration(
                        hintText: "Nome",
                        suffixIcon: Icon(
                          Icons.perm_contact_calendar,
                          size: 20.0,
                        )),
                    validator: (text) {
                      print(text.isEmpty);
                      if (text.isEmpty) {
                        return "O campo Nome é obrigatório";
                      }

                      return null;
                    }),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(fontSize: 14.0),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email.isEmpty) {
                      return 'O campo E-mail é obrigatório';
                    }

                    if (!email.contains('@')) {
                      return 'E-mail inválido';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "E-mail",
                      suffixIcon: Icon(
                        Icons.email,
                        size: 20.0,
                      )),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _passController,
                  style: TextStyle(fontSize: 14.0),
                  obscureText: true,
                  validator: (password) {
                    if (password.isEmpty) {
                      return 'O campo Senha é obrigatório';
                    }

                    if (password.length < 8) {
                      return 'O campo Senha precisa ter mais de 8 caracteres';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Senha",
                      suffixIcon: Icon(
                        Icons.lock_outline,
                        size: 20.0,
                      )),
                ),
                SizedBox(
                  height: 16.0,
                ),
                DateTimeField(
                  controller: _dateNasciController,
                  format: format,
                  validator: (date) {
                    if (date == null) {
                      return 'O campo Data de Nascimento é obrigatória';
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
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: typeBlood,
                    items: listDrop,
                    hint: Text(
                      "Tipo Sanguíneo",
                      style: TextStyle(fontSize: 14.0),
                    ),
                    elevation: 0,
                    onChanged: (value) {
                      setState(() {
                        typeBlood = value;
                      });
                    },
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      color: Color.fromRGBO(0, 91, 161, 1),
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    FlatButton(
                      color: Color.fromRGBO(0, 91, 161, 1),
                      child: Icon(Icons.attach_file, color: Colors.white),
                      onPressed: () {},
                    )
                  ],
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Map<String, dynamic> userData = {
                  "displayName": _nameController.text,
                  "email": _emailController.text,
                  "date_nasc": _dateNasciController.text,
                  "type_blood": typeBlood
                };

                model.signUp(
                    userData: userData,
                    pass: _passController.text,
                    onSuccess: _onSuccess,
                    onFailure: _onFailure);
              }
            },
            child: Icon(Icons.save),
            backgroundColor: Color.fromRGBO(0, 0, 153, 1),
          ),
        );
      },
    );
  }

  void _onSuccess() {
    // _scaffoldKey.currentState.showSnackBar(SnackBar(
    //   content: Text("Usuário criado com sucesso!"),
    //   backgroundColor: Theme.of(context).primaryColor,
    //   duration: Duration(seconds: 2),
    // ));

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CriarFilho()));

    // Future.delayed(Duration(seconds: 2)).then((_) {
    //   Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => HomePage()));
    // });
  }

  void _onFailure() {
    // _scaffoldKey.currentState.showSnackBar(SnackBar(
    //   content: Text("Erro ao salvar informações!"),
    //   backgroundColor: Colors.redAccent,
    //   duration: Duration(seconds: 2),
    // ));
  }
}
