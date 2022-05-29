// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, avoid_print, duplicate_ignore

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);
  @override
  State<IndexPage> createState() => _IndexPageState();
}

Map data = {};
final databaseRef = FirebaseDatabase.instance.ref();

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
    databaseRef.onValue.listen((event) {
      data = jsonDecode(jsonEncode(event.snapshot.value));
      print(data["speed"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
          stream: databaseRef.onValue,
          builder: (context, snap) {
            // ignore: avoid_print

            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return Stack(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0)),
                          child: Container(color: Colors.white10)),
                    ),
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Text(
                            "Tracker",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SfRadialGauge(
                              enableLoadingAnimation: true,
                              animationDuration: 5000,
                              axes: <RadialAxis>[
                                RadialAxis(
                                    minimum: 0,
                                    maximum: 180,
                                    axisLabelStyle:
                                        GaugeTextStyle(color: Colors.white),
                                    ranges: <GaugeRange>[
                                      GaugeRange(
                                          startValue: 0,
                                          endValue: 180,
                                          gradient: SweepGradient(colors: [
                                            Colors.green,
                                            Color.fromARGB(255, 159, 30, 233)
                                          ]))
                                    ],
                                    pointers: <GaugePointer>[
                                      NeedlePointer(
                                        value: double.parse(data["speed"]),
                                        needleColor:
                                            Color.fromARGB(255, 159, 30, 233),
                                      )
                                    ],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                          widget: Container(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("${data["speed"]}",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                              Text('Speed in km/h',
                                                  style: TextStyle(
                                                      color: Colors.white54)),
                                            ],
                                          )),
                                          angle: 90,
                                          positionFactor: 0.5)
                                    ])
                              ]),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text('Seat belts',
                                        style: TextStyle(
                                          color: Colors.white54,
                                        )),
                                    Text(
                                        data["allBeltsFastened"] == true
                                            ? 'Locked'
                                            : 'Unlocked',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                data["allBeltsFastened"] == true
                                                    ? Colors.green
                                                    : Color.fromARGB(
                                                        255, 159, 30, 233))),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Alcohol Status',
                                        style: TextStyle(
                                          color: Colors.white54,
                                        )),
                                    Text(
                                        data["isDrunk"] == true
                                            ? 'drunk'
                                            : 'Normal',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: data["isDrunk"] == true
                                                ? Color.fromARGB(
                                                    255, 159, 30, 233)
                                                : Colors.green)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                data["allBeltsFastened"] == false
                                    ? ClipOval(
                                        child: Material(
                                          color:
                                              Color.fromARGB(255, 159, 30, 233),
                                          elevation: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              MaterialCommunityIcons.seat,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : ClipOval(
                                        child: Material(
                                          color: Colors.white12,
                                          elevation: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              MaterialCommunityIcons.seat,
                                              size: 30,
                                              color: Colors.white54,
                                            ),
                                          ),
                                        ),
                                      ),
                                GestureDetector(
                                  onTap: () {
                                    databaseRef
                                        .child("play")
                                        .set(!data["play"]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 70),
                                    child: ClipOval(
                                      child: Material(
                                        color: double.parse(data["speed"]) >
                                                    80 ==
                                                true
                                            ? Color.fromARGB(255, 159, 30, 233)
                                            : Colors.green,
                                        elevation: 30,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            data["play"] == true
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                data["isDrunk"] == true
                                    ? ClipOval(
                                        child: Material(
                                          color:
                                              Color.fromARGB(255, 159, 30, 233),
                                          elevation: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              MaterialCommunityIcons
                                                  .bottle_wine,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : ClipOval(
                                        child: Material(
                                          color: Colors.white12,
                                          elevation: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              MaterialCommunityIcons
                                                  .bottle_wine,
                                              size: 30,
                                              color: Colors.white54,
                                            ),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
