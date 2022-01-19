import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';

import 'my_webview.dart';

final dropdownStringItems = [
  'Financial Services',
  'Zakat Services',
  'Assistance Application Form'
];

class DropDownList extends StatefulWidget {
  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  String dropdownValue = 'Financial Services';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: DropdownButton<String>(
          value: dropdownValue,
          underline: Container(),
          icon: Icon(Icons.arrow_drop_down_circle_rounded),
          iconSize: 30.0,
          // can be changed, default: 24.0
          iconEnabledColor: Colors.blue,
          hint: Text(
            "Select an Assistance Service to learn more",
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              if (newValue == dropdownStringItems[0]) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MyWebView(
                          title: newValue,
                          selectedUrl: "https://www.ismonline.org",
                        )));
              } else if (newValue == dropdownStringItems[1]) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MyWebView(
                          title: newValue,
                          selectedUrl: "https://www.ismonline.org",
                        )));
              } else if (newValue == dropdownStringItems[2]) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MyWebView(
                          title: newValue,
                          selectedUrl:
                              "https://fs20.formsite.com/OaBgTj/zuijxahprj/index.html",
                        )));
              }
            });
          },
          items: <String>[
            'Financial Services',
            'Zakat Services',
            'Assistance Application Form'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final int index;
  final urlImages = [
    'https://www.ismonline.org/assets/images/ism/ism-center.jpg',
    'https://www.ismonline.org/assets/images/history/ism-cover.jpeg',
  ];

  PlaceholderWidget(this.index);

  @override
  Widget build(BuildContext context) {
    // home page
    if (index == 2 || index == 4) {
      return Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "About Us",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "We are the largest Islamic organization in Wisconsin, serving the greater Milwaukee area since 1976.",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            CarouselSlider.builder(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 4),
                ),
                itemCount: urlImages.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = urlImages[index];
                  return buildImage(urlImage, index);
                }),
            Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Prayer Times",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.5),
                ),
              ),
            ),
            Html(data: """
              <iframe id="iframe" title="prayerWidget" class="widget-m-top" style=" height: 400px; border: 1px solid #ddd;" scrolling="no" src="https://www.islamicfinder.org/prayer-widget/5263045/shafi/5/0/15.0/15.0"> </iframe>
              """),
            Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Events",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.5),
                ),
              ),
            ),
            SfCalendar(
              view: CalendarView.schedule,
              dataSource: MeetingDataSource(getAppointmentsOld()),
            ),
          ],
        ),
      );
    }
    // services tab
    else if (index == 3) {
      return Container(
        child: Scrollbar(
          thickness: 8,
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Services",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "The ISM offers numerous services for the Milwaukee Muslim community.\n\nPlease click on the icons below to view more information about each service.",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.25),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.tour),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "Tour Services",
                            selectedUrl: "https://www.ismonline.org/tours.html",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Tours",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.mic_outlined),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "Speaker Request",
                            selectedUrl:
                                "https://www.ismonline.org/speaker-request.html",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Speaker Request",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.home_filled),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "Facility Rental",
                            selectedUrl:
                                "https://fs20.formsite.com/OaBgTj/1oaurxxnrd/index.html",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Facility Rental Form",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.hourglass_top_rounded),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "Funeral Services",
                            selectedUrl:
                                "https://www.ismonline.org/funeral.html",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Funeral Services",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.people_alt_rounded),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "New Muslim Services",
                            selectedUrl: "https://www.ismonline.org",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "New Muslim Services",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.child_care),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "Foster Care Services",
                            selectedUrl: "https://www.ismonline.org",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Foster Care Services",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.monetization_on),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "Financial Services",
                            selectedUrl: "https://www.ismonline.org",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Financial Services",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.money),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "Zakat Services",
                            selectedUrl: "https://www.ismonline.org",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Zakat Services",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.description_rounded),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "Assistance Application Form",
                            selectedUrl:
                                "https://fs20.formsite.com/OaBgTj/zuijxahprj/index.html",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Assistance Application Form",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.emoji_people),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "Matrimony and Matchmaking Services",
                            selectedUrl:
                                "https://www.ismonline.org/matrimonial-service.html",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Matrimony and Matchmaking Services",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.tag_faces),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "Nikah Services",
                            selectedUrl: "https://www.ismonline.org",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Nikah Services",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.perm_phone_msg),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "Marriage and Divorce Counseling",
                            selectedUrl: "https://www.ismonline.org",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Marriage and Divorce Counseling",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.family_restroom),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "Family Counseling",
                            selectedUrl: "https://www.ismonline.org",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Family Counseling",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.fastfood),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "Food Pantry",
                            selectedUrl: "https://www.ismonline.org",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Food Pantry",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new SizedBox(
              height: 28.0,
              width: 28.0,
              child: new IconButton(
                padding: EdgeInsets.all(1.0),
                constraints: BoxConstraints(),
                icon: new Icon(Icons.stars_outlined),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                            title: "Interfaith",
                            selectedUrl: "https://www.ismonline.org",
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Interfaith",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ),
            ),
            //DropDownList(),
          ]),
        ),
      );
    }
    // more tab
    else if (index == 5) {
      return Container(
        color: Colors.white,
        child: Scrollbar(
          thickness: 8,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              new SizedBox(
                height: 28.0,
                width: 28.0,
                child: new IconButton(
                  padding: EdgeInsets.all(1.0),
                  constraints: BoxConstraints(),
                  icon: new Icon(Icons.video_collection),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyWebView(
                              title: "ISM YouTube",
                              selectedUrl:
                                  "https://www.youtube.com/channel/UCUp44adV2KiiccggAauEJnQ",
                            )));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "YouTube",
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              new SizedBox(
                height: 28.0,
                width: 28.0,
                child: new IconButton(
                  padding: EdgeInsets.all(1.0),
                  constraints: BoxConstraints(),
                  icon: new Icon(Icons.facebook),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyWebView(
                              title: "ISM Facebook",
                              selectedUrl:
                                  "https://www.facebook.com/IslamicSocietyofMilwaukee/",
                            )));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Facebook",
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              new SizedBox(
                height: 28.0,
                width: 28.0,
                child: new IconButton(
                  padding: EdgeInsets.all(1.0),
                  constraints: BoxConstraints(),
                  icon: new Icon(Icons.camera_alt),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyWebView(
                              title: "ISM Instagram",
                              selectedUrl:
                                  "https://www.instagram.com/ismmilwaukee/",
                            )));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Instagram",
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              new SizedBox(
                height: 28.0,
                width: 28.0,
                child: new IconButton(
                  padding: EdgeInsets.all(1.0),
                  constraints: BoxConstraints(),
                  icon: new Icon(Icons.school),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyWebView(
                              title: "Salam School",
                              selectedUrl: "https://salamk12.org/",
                            )));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Salam School",
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.0),
                  ),
                ),
              ),
              /*
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new SizedBox(
                  height: 35.0,
                  width: 15.0,
                  child: new IconButton(
                    icon: new Icon(Icons.video_collection),
                    onPressed: () async {
                      const url =
                          'https://www.youtube.com/channel/UCUp44adV2KiiccggAauEJnQ';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "YouTube",
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.5),
                  ),
                ),
                new SizedBox(
                  height: 35.0,
                  width: 15.0,
                  child: new IconButton(
                    icon: new Icon(Icons.facebook),
                    onPressed: () async {
                      const url =
                          'https://www.facebook.com/IslamicSocietyofMilwaukee/';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Facebook",
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.5),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new SizedBox(
                  height: 35.0,
                  width: 15.0,
                  child: new IconButton(
                    icon: new Icon(Icons.camera_alt),
                    onPressed: () async {
                      const url = 'https://www.instagram.com/ismmilwaukee/';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Instagram",
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.5),
                  ),
                ),
                new SizedBox(
                  height: 35.0,
                  width: 15.0,
                  child: new IconButton(
                    icon: new Icon(Icons.school),
                    onPressed: () async {
                      const url = 'https://salamk12.org/';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Salam School",
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.5),
                  ),
                ),
              ],
            ),*/
            ],
          ),
        ),
      );
    }
    // to be implemented
    else {
      return Container(
        color: Colors.white,
      );
    }
  }

  Widget buildImage(String urlImage, int index) => Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.white,
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ));
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
