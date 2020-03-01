import 'package:flutter/material.dart';
import 'package:materno_infantil/models/user_model.dart';
import 'package:materno_infantil/ui/criar_filhos.dart';
import 'package:materno_infantil/ui/tela_cadastrar.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _userModel = UserModel();

  @override
  void dispose() {
    _userModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Diário Saúde'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 91, 161, 1),
        ),
        body: ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              if (model.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(15.0),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(
                          Icons.person_pin,
                          size: 100.0,
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          'Entrar com',
                          style:
                          TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              child: Text(
                                'Google',
                                style: TextStyle(fontSize: 18),
                              ),
                              textColor: Colors.white,
                              color: Color.fromRGBO(221, 75, 57, 1),
                              onPressed: () async {
                                await model.signInGoogle();
                              },
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            RaisedButton(
                              child: Text(
                                'Facebook',
                                style: TextStyle(fontSize: 18),
                              ),
                              textColor: Colors.white,
                              color: Color.fromRGBO(59, 86, 157, 1),
                              onPressed: () async {
                                await model.signInFacebook();
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (email) {
                        if (email.isEmpty || !email.contains('@')) {
                          return 'E-mail inválido';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _passController,
                      obscureText: true,
                      validator: (password) {
                        if (password.isEmpty || password.length < 8) {
                          return 'Senha inválida';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Senha',
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TelaCadastrar()));
                          },
                          child: Text(
                            'Cadastrar',
                            textAlign: TextAlign.left,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Esqueci minha senha',
                            textAlign: TextAlign.right,
                          ),
                          padding: EdgeInsets.zero,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RaisedButton(
                      child: Text(
                        'Entrar',
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      color: Color.fromRGBO(0, 0, 153, 1),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await model.signInWithEmailAndPass(
                              email: _emailController.text,
                              password: _passController.text,
                              onSuccess: onSuccess,
                              onFailure: onFailure);
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              );
            }
        ));
  }

  void onSuccess() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => CriarFilho()));
  }

  void onFailure() {}
}
