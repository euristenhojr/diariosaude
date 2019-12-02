import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:materno_infantil/ui/cadastrar_evento.dart';

class EventoCalendario extends StatefulWidget {
  @override
  _EventoCalendarioState createState() => _EventoCalendarioState();
}

class _EventoCalendarioState extends State<EventoCalendario> {
  CalendarController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CadastrarEvento()));
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
                        /*formatButtonDecoration: BoxDecoration(
                      color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                      formatButtonTextStyle: TextStyle(
                        color: Colors.white
                      ),*/
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(fontSize: 14.0),
                      ),
                      events: _selectedDay,
                      builders: CalendarBuilders(
                        markersBuilder: (context, date, events, holidays) {
                          return [
                            Container(
                              decoration: new BoxDecoration(
                                color: Color.fromARGB(0xFF, 0x45, 0x95, 0xBA),
                                shape: BoxShape.circle,
                              ),
                              margin: const EdgeInsets.all(2.0),
                              width: 4,
                              height: 4,
                            )
                          ];
                        },
                      ),
                      initialCalendarFormat: CalendarFormat.month,
                      onDaySelected: (date, events) {
                        print(date.toIso8601String());
                      },
                      calendarController: _controller),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Container(
                    color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                    height: 60.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: CircleAvatar(
                              backgroundImage: ExactAssetImage(
                                'images/rosto1.jpg',
                              ),
                              minRadius: 15.0,
                              maxRadius: 20.0,
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 5.0),
                            child: Container(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Filha: Angelina",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "  Vacina  ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        backgroundColor: Colors.teal),
                                  ),
                                  Text(
                                    "Immunite",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Container(
                                  height: 5.0,
                                  width: 5.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Container(
                                  height: 5.0,
                                  width: 5.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Container(
                                  height: 5.0,
                                  width: 5.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Container(
                    color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                    height: 60.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: CircleAvatar(
                              backgroundImage: ExactAssetImage(
                                'images/rosto1.jpg',
                              ),
                              minRadius: 15.0,
                              maxRadius: 20.0,
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 5.0),
                            child: Container(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Filha: Angelina",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    " Acompanhamento Médico ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.amber),
                                  ),
                                  Text(
                                    "Fonoaudióloga",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Container(
                                  height: 5.0,
                                  width: 5.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Container(
                                  height: 5.0,
                                  width: 5.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Container(
                                  height: 5.0,
                                  width: 5.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Container(
                    color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                    height: 60.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: CircleAvatar(
                              backgroundImage: ExactAssetImage(
                                'images/rosto1.jpg',
                              ),
                              minRadius: 15.0,
                              maxRadius: 20.0,
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 5.0),
                            child: Container(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Filha: Angelina",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    " Rotina ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        backgroundColor: Colors.brown),
                                  ),
                                  Text(
                                    "Antibiótico",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Container(
                                  height: 5.0,
                                  width: 5.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Container(
                                  height: 5.0,
                                  width: 5.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Container(
                                  height: 5.0,
                                  width: 5.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  final Map<DateTime, List> _selectedDay = {
    DateTime(2019, 9, 3): ['Selected Day in the calendar!'],
    DateTime(2019, 9, 5): ['Selected Day in the calendar!'],
    DateTime(2019, 9, 22): ['Selected Day in the calendar!'],
    DateTime(2019, 9, 22): ['Selected Day in the calendar!'],
    DateTime(2019, 9, 26): ['Selected Day in the calendar!'],
  };
}
