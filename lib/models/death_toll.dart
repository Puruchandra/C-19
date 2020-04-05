import 'package:corona_stats/models/stats.dart';
import 'package:corona_stats/services/index.dart';
import 'package:flutter/material.dart';

class DeathToll {
  String provinceState;
  int lastUpdate;
  int long;
  int lat;
  Stats stats;
  Country country;
  String incidentRate;
  String peopleTested;

  DeathToll.fromApiResponse(parsedJson) {
    provinceState = parsedJson["provinceState"];
    lastUpdate = parsedJson["lastUpdate"];
    lastUpdate = parsedJson["lastUpdate"];
    stats = Stats(
        confirmed: parsedJson["confirmed"],
        recoverd: parsedJson["recovered"],
        deaths: parsedJson["deaths"]);
    country = Country.fromDeathToll(parsedJson);
  }
}

class DeathTollProvider extends ChangeNotifier {
  List<DeathToll> deathTollList = [];
  bool fetching;
  String errMsg;
  InternetService service = InternetService();

  DeathTollProvider() {
    getGlobalDeathTool();
  }

  void getGlobalDeathTool() async {
    try {
      fetching = true;
      notifyListeners();
      deathTollList = await service.getGlobalDeathsToll();
      errMsg = null;
      fetching = false;
      notifyListeners();
    } catch (e) {
      errMsg = e.toString();
      fetching = false;
      notifyListeners();
    }
  }
}
