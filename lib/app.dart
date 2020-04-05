import 'package:corona_stats/Screens/homescreen.dart';
import 'package:corona_stats/models/death_toll.dart';
import 'package:corona_stats/models/stats.dart';
import 'package:corona_stats/screens/homescreen.dart';
import 'package:corona_stats/screens/splashscreen.dart';
import 'package:corona_stats/services/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    InternetService().getGlobalDailyStats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StatsProvider>.value(
          value: StatsProvider(),
        ),
        ChangeNotifierProvider<DeathTollProvider>.value(
          value: DeathTollProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (BuildContext context) => SplashScreen(),
        },
      ),
    );
  }
}
