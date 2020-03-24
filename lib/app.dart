import 'package:corona_stats/Screens/homescreen.dart';
import 'package:corona_stats/screens/splashscreen.dart';
import 'package:corona_stats/services/index.dart';
import 'package:flutter/material.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // onGenerateRoute: (RouteSettings settings){
      //   return null;
      // },
      routes: {
        '/': (BuildContext context) => SplashScreen(),
      },
    );
  }
}
