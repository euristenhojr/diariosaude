import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TableCalendar(
                  locale: 'pt_BR',
                  calendarStyle: CalendarStyle(
                    todayColor: Color.fromARGB(0xFF, 0x45, 0x95, 0xBA),
                    selectedColor: Color.fromARGB(0xFF, 0x04, 0x29, 0x3B),

                  ),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonDecoration: BoxDecoration(
                      color: Color.fromARGB(0xFF, 0x08, 0x4D, 0x6E),
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                      formatButtonTextStyle: TextStyle(
                        color: Colors.white
                      ),
                    titleTextStyle: TextStyle(fontSize: 14.0),
                  ),
                  calendarController: _controller)
            ],
          ),
        ));
  }
}
