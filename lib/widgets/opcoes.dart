import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Opcoes extends StatelessWidget {

  final IconData icon;
  final String nome;
  final double tamFonte;

  Opcoes(this.icon, this.nome, this.tamFonte);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: Icon(icon,
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
            nome,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: tamFonte),
          ),
        ),
      ],
    );
  }
}
