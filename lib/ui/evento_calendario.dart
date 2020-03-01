import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:materno_infantil/datas/child_data.dart';
import 'package:materno_infantil/datas/event_data.dart';
import 'package:materno_infantil/models/event_model.dart';
import 'package:materno_infantil/models/user_model.dart';
import 'package:materno_infantil/tile/event_tile.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:materno_infantil/ui/cadastrar_evento.dart';
import 'package:intl/intl.dart';

class EventoCalendario extends StatefulWidget {

  final ChildData childData;
  EventoCalendario(this.childData);

  @override
  _EventoCalendarioState createState() => _EventoCalendarioState(childData);

}


class _EventoCalendarioState extends State<EventoCalendario> {

  final ChildData childData;
  _EventoCalendarioState(this.childData);
  CalendarController _controller;

  final format = DateFormat("dd-MM-yyyy");
  String data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data != null ? data= data : data = format.format(DateTime.now());
    _controller = CalendarController();
  }

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
            onPressed: ( ) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CadastrarEvento(data, childData)));
            },
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(0xFF, 0x1B, 0x30, 0xA1)),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: TableCalendar(
                      locale: 'pt_BR',
                      calendarStyle: CalendarStyle(
                        todayColor: Color.fromARGB(0xFF, 0x45, 0x95, 0xBA),
                        selectedColor: Color.fromARGB(0xFF, 0x04, 0x29, 0x3B),
                      ),
                      headerStyle: HeaderStyle(
                        centerHeaderTitle: true,
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(fontSize: 14.0),
                      ),
                      events: _selectedDay,
                      builders:
                      CalendarBuilders(
                          markersBuilder: (context, date, events, holidays) {
                            return [
                              Container(
                                decoration: new BoxDecoration(
                                  color: Color.fromARGB(0xFF, 0x45, 0x95, 0xBA),
                                  shape: BoxShape.circle,
                                ),
                                margin: const EdgeInsets.all(2.0),
                                width: 10,
                                height: 10,
                              )
                            ];
                          },
                      )
                      ,
                      initialCalendarFormat: CalendarFormat.month,
                      onDaySelected: (date, events) {
                        //print(date.toIso8601String());
                        //print(format.format(date));
                        data = format.format(date);
                      },
                      calendarController: _controller),
                ),
                 ScopedModelDescendant<EventModel>(builder: (context, child, modelEvent){
                    modelEvent.loadEvents(childData);
                    modelEvent.listFilter(data);
                    if(modelEvent.listEvents.length == 0){
                      return Text("");
                    }
                    return Column(
                      children: modelEvent.listEventsFilter.map((event) {
                        //modelEvent.loadDate(event.dateEvent);
                        return Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 4.0),
                            child: EventTile(event, childData));
                      }).toList(),
                    );
                  }),
              ],
            ),
          ),
        ));
  }

  final Map<DateTime, List> _selectedDay = {
    DateTime(3, 2, 2020): ['Selected Day in the calendar!'],
    DateTime(2020, 1, 5): ['Selected Day in the calendar!'],
    DateTime(2019, 9, 22): ['Selected Day in the calendar!'],
    DateTime(2019, 9, 22): ['Selected Day in the calendar!'],
    DateTime(2019, 9, 26): ['Selected Day in the calendar!'],
  };

}


