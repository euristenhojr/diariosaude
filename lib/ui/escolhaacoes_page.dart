import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:materno_infantil/datas/child_data.dart';
import 'package:materno_infantil/datas/vacina_data.dart';
import 'package:materno_infantil/models/event_model.dart';
import 'package:materno_infantil/models/user_model.dart';
import 'package:materno_infantil/models/vacina_model.dart';
import 'package:materno_infantil/ui/add_filhos_page.dart';
import 'package:materno_infantil/ui/evento_calendario.dart';
import 'package:materno_infantil/widgets/opcoes.dart';
import 'package:scoped_model/scoped_model.dart';

class EscolhaAcoes extends StatefulWidget {
  ChildData childData;
  List<VacinaData> listVacinaData;
  EscolhaAcoes(this.childData, this.listVacinaData);

  @override
  _EscolhaAcoesState createState() => _EscolhaAcoesState(childData, listVacinaData);
}

class _EscolhaAcoesState extends State<EscolhaAcoes> {
  final ChildData childData;
  List<VacinaData> listVacinaData;
  _EscolhaAcoesState(this.childData, this.listVacinaData);

  EventModel eventModel;
  List<VacinaData> vacinas;
  List<String> nomeVacinas;
  DateTime dataAtual = DateTime.now();
  DateTime dataNasc;
  DateTime idade;
  String intervalo;

  @override
  void initState() {
    super.initState();
    if(childData.dataNasc != null) {

      dataNasc = _transfomarStringToDate(childData.dataNasc);
      idade = _transfomarStringToDate(_calculaIdade(dataAtual, dataNasc));
      intervalo = _intervaloVacina(idade);
      vacinas = listVacinaData.where((filter) => filter.idade.compareTo(intervalo) == 0).toList();
      nomeVacinas = vacinas.map((f) => f.nomeVacina).toList();

      if (vacinas.isNotEmpty) {
        SchedulerBinding.instance.addPostFrameCallback((_) =>
            showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      title: Text(vacinas.length > 1 ? "Vacinas" : "Vacina"),
                      content: Text("" + nomeVacinas.toString()),
                    )));
      }
    }

  }

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
                                    image: NetworkImage(childData.image != null
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddFilhos(childData)));
                      },
                      child: Opcoes(MdiIcons.accountCardDetails, "Dados Básicos", 12.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EventoCalendario(childData, "vacina")));
                      },
                      child: Opcoes(MdiIcons.heartPulse, "Vacina", 14.0),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EventoCalendario(childData, "rotina")));
                      },
                      child: Opcoes(Icons.assignment, "Rotina", 14.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Opcoes(MdiIcons.accountPlusOutline, "Crescimento", 14.0),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Opcoes(MdiIcons.heart, "Médico", 14.0),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Opcoes(MdiIcons.accountChildCircle, "Relatórios", 14.0),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  DateTime _transfomarStringToDate(String data){
    String dataParse;
    DateTime date;
    dataParse = data.substring(6,10);
    dataParse = dataParse + "-" + data.substring(3,5);
    dataParse = dataParse + "-" + data.substring(0,2);
    dataParse = dataParse + " 12:00";
    date = DateTime.parse(dataParse);
    return date;
  }

  String _calculaIdade(DateTime data, DateTime nasc){

    int dia; int ano; int mes;
    String idade;

    ano = data.year - nasc.year;
    mes = data.month - nasc.month;
    dia = data.day - nasc.day;

    if(mes<0){
      ano = ano -1;
      mes = 12 + mes;
    }
    if(dia<0){
      mes = mes -1;
      dia = 30 + dia;
    }
    if(dia <= 9){
       idade = "0" + dia.toString();
    }else {
      idade = dia.toString();
    }
    if(mes <= 9) {
      idade = idade + "-0" + mes.toString();
    }else{
      idade = idade + "-" + mes.toString();
    }if(ano<=9){
      idade = idade + "-000" + ano.toString();
    }else{
      idade = idade + "-00" + ano.toString();
    }

    return idade;
  }

  String _intervaloVacina(DateTime idade){

    if(idade.year == 0 && idade.month ==0 && idade.day < 10 ){
      return "00-00-0000";
    }
    else if(idade.year == 0 && idade.month == 1 && idade.day < 15){
      return "00-02-0000";
    }
    else if(idade.year == 0 && idade.month == 2 && idade.day < 15){
      return "00-03-0000";
    }
    else if(idade.year == 0 && idade.month == 3 && idade.day < 15){
      return "00-04-0000";
    }
    else if(idade.year == 0 && idade.month == 4 && idade.day < 15){
      return "00-05-0000";
    }
    else if(idade.year == 0 && idade.month == 5 && idade.day < 15){
      return "00-06-0000";
    }
    else if(idade.year == 0 && idade.month == 8 && idade.day < 15){
      return "00-09-0000";
    }
    else if(idade.year == 0 && idade.month == 11 && idade.day < 15){
      return "00-00-0001";
    }
    else if(idade.year == 1 && idade.month == 3 && idade.day < 15){
      return "00-03-0001";
    }
    else if(idade.year == 3 && idade.month == 11 && idade.day < 15){
      return "00-00-0004";
    }

    return "00-00-0100";
  }
}
