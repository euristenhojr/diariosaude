import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diário Saúde"),
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
              padding: EdgeInsets.fromLTRB(0, 30.0, 0, 30),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text("Logar com Facebook",
                      style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text("Logar com Google",
                      style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                  onPressed: () {},
                ),
              ],
            ),
            TextField(keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Login: ",
                  labelStyle: TextStyle(color: Colors.grey)
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
            ),
            TextField(keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Password: ",
                  labelStyle: TextStyle(color: Colors.grey)
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13.0),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 35.0,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text("Entrar", style: TextStyle(color: Colors.white, fontSize: 15.0)),
                    color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                  ),
                ),

            ),
          ],
        ),
      )
    );
  }
}
