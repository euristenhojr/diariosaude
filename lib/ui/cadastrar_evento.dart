import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:materno_infantil/datas/child_data.dart';
import 'package:materno_infantil/datas/event_data.dart';
import 'package:materno_infantil/models/event_model.dart';
import 'package:materno_infantil/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CadastrarEvento extends StatefulWidget {
  final DateTime data;
  final ChildData childData;
  final String escolhaAcao;
  CadastrarEvento(this.data, this.childData, this.escolhaAcao);

  @override
  _CadastrarEventoState createState() => _CadastrarEventoState(data, childData, escolhaAcao);
}

class _CadastrarEventoState extends State<CadastrarEvento> {
  DateTime data;
  final ChildData childData;
  final String escolhaAcao;
  _CadastrarEventoState(this.data, this.childData, this.escolhaAcao);

  final _nameEventController = TextEditingController();
  final _localeEventController = TextEditingController();
  final _descriptionEventController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String nome = "Cadastrar Evento";
  String eventSelecionado;
  final format = DateFormat("dd-MM-yyyy");

  List<DropdownMenuItem<String>> listDrop = [];

  void loadData() {
    listDrop = [];

    listDrop.add(new DropdownMenuItem(
      child: new Text("Acompanhamento Médico"),
      value: 'Médico',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Vacina"),
      value: 'vacina',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Rotina"),
      value: 'rotina',
    ));
  }

  @override
  void initState() {
    super.initState();
    eventSelecionado = escolhaAcao;
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return ScopedModelDescendant<EventModel>(
          builder: (context, child, eventModel) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text("Cadastrar Evento",
                style: TextStyle(fontSize: 14.0),
              ),
              backgroundColor: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.child_care), onPressed: () {})
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (_formKey.currentState.validate() &&
                    eventSelecionado != null) {
                  EventData eventData = EventData();
                  eventData.nameEvent = _nameEventController.text;
                  eventData.typeEvent = eventSelecionado;
                  eventData.localeEvent = _localeEventController.text;
                  eventData.descriptionEvent = _descriptionEventController.text;
                  eventData.dateEvent = data;
                  eventData.cid = childData.cid;

                  bool result = await eventModel.addEventData(eventData);
                  if (result) {
                    _onSucess();
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => _nameEventController.clear());
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => _localeEventController.clear());
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => _descriptionEventController.clear());
                    Navigator.of(context).pop();
                  }
                }
              },
              child: Icon(Icons.save),
              backgroundColor: Color.fromARGB(0xFF, 0x1B, 0x30, 0xA1),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 2.0, bottom: 20.0),
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(0xFF, 0xA9, 0xA9, 0xA9),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(childData.image !=
                                        null
                                    ? childData.image
                                    : "https://www.maxfesta.com.br/imagens/produtos/28740/Detalhes/tnt-azul-marinho-metro.jpg"),
                                minRadius: 15.0,
                                maxRadius: 20.0,
                              )),
                          Container(
                            width: 130,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                childData.nome,
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 30.0,
                          child: Text(
                            format.format(data),
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: eventSelecionado,
                            items: listDrop,
                            hint: Text(
                              "Tipo de Evento",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            elevation: 0,
                            onChanged: (value) {
                              eventSelecionado = value;
                              setState(() {});
                            },
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                            height: 50.0,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: TextFormField(
                                controller: _nameEventController,
                                style: TextStyle(fontSize: 14.0),
                                validator: (name) {
                                  if (name.isEmpty) {
                                    return "O campo Título do Evento é obrigatorio";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Título do Evento",
                                    suffixIcon: Icon(
                                      Icons.title,
                                      size: 20.0,
                                    )),
                              ),
                            )),
                        Container(
                            height: 50.0,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: TextFormField(
                                controller: _localeEventController,
                                style: TextStyle(fontSize: 14.0),
                                validator: (localeEvent) {
                                  if (localeEvent.isEmpty) {
                                    return "O campo Adicionar Local é obrigatorio";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Adicionar Local",
                                    suffixIcon: Icon(
                                      Icons.location_on,
                                      size: 20.0,
                                    )),
                              ),
                            )),
                        Container(
                            height: 50.0,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: TextFormField(
                                controller: _descriptionEventController,
                                style: TextStyle(fontSize: 14.0),
                                validator: (descriptionEvent) {
                                  if (descriptionEvent.isEmpty) {
                                    return "O campo Descrição é obrigatorio";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Adicionar uma Descrição",
                                    suffixIcon: Icon(
                                      Icons.assignment,
                                      size: 20.0,
                                    )),
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0, bottom: 5.0, top: 20.0),
                              child: Container(
                                height: 35,
                                width: 50,
                                child: Icon(
                                  Icons.photo_camera,
                                  color: Colors.white,
                                ),
                                color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0, bottom: 5.0, top: 20.0),
                              child: Container(
                                height: 35,
                                width: 50,
                                child: Icon(
                                  Icons.attach_file,
                                  color: Colors.white,
                                ),
                                color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      });
    });
  }

  void _onSucess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Evento Criado com Sucesso!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 1),
    ));
  }
}
