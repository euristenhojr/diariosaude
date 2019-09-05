import 'package:flutter/material.dart';

class escolhaAcoes extends StatefulWidget {
  @override
  _escolhaAcoesState createState() => _escolhaAcoesState();
}

class _escolhaAcoesState extends State<escolhaAcoes> {
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          //backgroundColor: Color.fromARGB(0xFF, 0x7A, 0x48, 0x27),
          //backgroundColor: Color.fromARGB(0xFF, 0x1B, 0x30, 0xA1),
          //backgroundColor: Color.fromARGB(0xFF, 0xA1, 0x3D, 0x1B),
          //backgroundColor: Color.fromARGB(0xFF, 0x1B, 0x30, 0xA1),
          //backgroundColor: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB( 5.0, 0.0, 5.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                child:
                Container(
                  height: 70.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
                child:
                Container(
                  height: 14.0,
                  child: Text("Bem Vindo Papai Bruno !", textAlign: TextAlign.center,),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                child:
                Container(
                  height: 14.0,
                  child: Text("Fortaleza, 16 de Setembro de 2019",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10.0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                child:
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color.fromARGB(0xFF, 0x1B, 0x30, 0xA1),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child:
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child:
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
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
                    child:
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child:
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
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
                    child:
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child:
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
