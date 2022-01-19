import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/models/my_webview.dart';
import '../models/event_model.dart';
import 'dart:convert' as convert;
import 'package:url_launcher/url_launcher.dart';
import '../models/placeholder_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 2; // keep track of current tab, default is home page
  final List<Widget> _children = [
    PlaceholderWidget(0),
    PlaceholderWidget(1),
    PlaceholderWidget(2),
    PlaceholderWidget(3),
    PlaceholderWidget(4),
    PlaceholderWidget(5),
  ];
  // list of widgets that we want to render based on the currently selected tab

  List<EventModel> events = <EventModel>[];
  List<Appointment> appts = <Appointment>[];

  Future<List<EventModel>> getEventsFromSheet() async {
    var rawData = await http.get(
        "https://script.google.com/macros/s/AKfycbz-mDLrVJBwfGOLilCV0Qfk8UAdhK03lDqwdMuBF2nq4C2ibZdsPgNHih4pW6CNDgag/exec");

    var jsonEvents = convert.jsonDecode(rawData.body);
    print('THIS is JSON EVENT $jsonEvents');

    events = jsonEvents
        .map<EventModel>((json) => EventModel.fromJson(json))
        .toList();
    print('TESTING EVENTS $events');

    return events;
  }

  @override
  void initState() {
    getEventsFromSheet();
    super.initState();
  }

  Future<List<Appointment>> getAppointments() async {
    var events = await getEventsFromSheet();
    List<Appointment> meetings = <Appointment>[];

    for (EventModel e in events) {
      int monthDash = e.startDate.indexOf('/');
      int month = e.startDate.substring(0, monthDash) as int;
      int dayDash = e.startDate.indexOf('/', monthDash + 1);
      int day = e.startDate.substring(monthDash + 1, dayDash) as int;
      int year = e.startDate.substring(dayDash + 1) as int;
      int startTimeHour = e.startTimeHr as int;
      int startTimeMinute = e.startTimeMin as int;
      int duration = e.duration as int;

      final DateTime startTime =
          DateTime(year, month, day, startTimeHour, startTimeMinute, 0);

      final DateTime endTime = startTime.add(Duration(hours: duration));

      Appointment a = new Appointment(
        startTime: startTime,
        endTime: endTime,
        color: Colors.blue,
        subject: e.title,
        isAllDay: false,
      );

      meetings.add(a);
    }

    appts = meetings;

    return meetings.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text('Islamic Society of Milwaukee'),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              padding: EdgeInsets.all(1.0),
              constraints: BoxConstraints(),
              icon: new Icon(Icons.list),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MyWebView(
                      title: "ISM Events",
                      selectedUrl: "https://www.ismonline.org/events.html",
                    )
                ));
              },
            ),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              padding: EdgeInsets.all(1.0),
              constraints: BoxConstraints(),
              icon: new Icon(Icons.announcement),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MyWebView(
                      title: "ISM News & Announcements",
                      selectedUrl: "https://www.ismonline.org/blog",
                    )
                ));
              },
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.people_alt_rounded),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              padding: EdgeInsets.all(1.0),
              constraints: BoxConstraints(),
              icon: new Icon(Icons.attach_money),
              onPressed: () async {
                const url = 'https://donate.chip-in.us/?nonprofitId=121652';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            label: 'Donate',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class EventCalendar extends StatelessWidget {
  String category,
      title,
      startDate,
      endDate,
      location,
      startTimeHr,
      startTimeMin,
      duration,
      recurrence;

  EventCalendar(
      {required this.category,
      required this.title,
      required this.startDate,
      required this.endDate,
      required this.location,
      required this.startTimeHr,
      required this.startTimeMin,
      required this.duration,
      required this.recurrence});

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [Row(children: [])]));
  }
}

List<Appointment> getAppointmentsOld() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, 6, 4, 13, 10, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 1));

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Jumuah',
      color: Colors.blue,
      recurrenceRule: 'FREQ=DAILY;INTERVAL=7',
      isAllDay: false));

  return meetings;
}
