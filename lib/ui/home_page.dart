import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:materno_infantil/ui/tela_cadastrar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diário Saúde'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 91, 161, 1),
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: 100.0,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Entrar com',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                      onPressed: () {},
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
                      onPressed: () {},
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
              decoration: InputDecoration(
                hintText: 'E-mail',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Senha',
              ),
              obscureText: true,
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
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
//      floatingActionButton: ,
    );
  }
}
