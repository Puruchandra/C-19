import 'dart:async';

import 'package:corona_stats/models/stats.dart';
import 'package:corona_stats/screens/widgets/custom_bottom_sheet.dart';
import 'package:corona_stats/screens/widgets/data_card.dart';
import 'package:corona_stats/screens/widgets/exception_handler_widget.dart';
import 'package:corona_stats/screens/widgets/pie_card.dart';
import 'package:corona_stats/screens/widgets/text_stats_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool displayWait = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        displayWait = true;
      });
    });

    super.initState();
  }

  StatsProvider model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(Icons.notifications, color: Colors.blue),
        //       onPressed: null)
        // ],
        elevation: 0.0,
        title: Text('Covid-19'),
        centerTitle: false,
        backgroundColor: Color(0xff0F111A),
      ),
      drawer: Drawer(child: ListView()),
      backgroundColor: Color(0xff0F111A),
      body: ChangeNotifierProvider<StatsProvider>(
        create: (ctx) => StatsProvider(),
        child: Consumer(
            builder: (BuildContext context, StatsProvider value, Widget child) {
          model = value;
          if (value.fetching) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  displayWait
                      ? Text("This is taking longer than usual. Please wait...",
                          style: TextStyle(
                            color: Colors.white,
                          ))
                      : Container()
                ],
              ),
            );
          }
          if (!value.fetching && value.errMsg != null) {
            return ExceptionHandlerWidget(
              errMsg: value.errMsg,
            );
          }
          if (value.gloablstats != null) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('${value.statsOf}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            )),
                        Row(
                          children: <Widget>[
                            Icon(Icons.access_time, color: Colors.white),
                            SizedBox(width: 8.0),
                            Text(
                                value.gloablstats.lastUpadte != '0'
                                    ? '${value.gloablstats.lastUpadte} hour ago.'
                                    : 'minutes ago.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    buildStats(value),
                    SizedBox(height: 16.0),
                    buildRatings(value),
                    SizedBox(height: 16.0),
                    PieCard(model: value),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: ExceptionHandlerWidget(
              errMsg: 'Nothing to Display',
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.public,
          size: 50.0,
        ),
        onPressed: model != null
            ? () {
                setState(() {
                  displayWait = false;
                });

                showModalBottomSheet(
                    context: context,
                    builder: (_) => CustomBottomSheet(
                          model: model,
                        ));
              }
            : null,
      ),
    );
  }

  buildStats(value) {
    return DataCard(
      children: <Widget>[
        TextStatsCard(
          label: 'Confirmed',
          numbers: value.gloablstats.confirmed.toString(),
          color: Color(0xfff2b903),
        ),
        TextStatsCard(
            label: 'Recoverd',
            numbers: value.gloablstats.recoverd.toString(),
            color: Colors.green),
        TextStatsCard(
          label: 'Deaths',
          numbers: value.gloablstats.deaths.toString(),
          color: Colors.red,
        )
      ],
    );
  }

  buildRatings(value) {
    return DataCard(
      children: <Widget>[
        TextStatsCard(
          label: 'Recovery Rate',
          numbers: value.gloablstats.recoveryRate,
          color: Colors.green,
        ),
        TextStatsCard(
            label: 'Fatality Rate',
            numbers: value.gloablstats.fatalityRate,
            color: Colors.red),
      ],
    );
  }
}
