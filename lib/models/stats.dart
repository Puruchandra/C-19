import 'package:corona_stats/services/index.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatsProvider extends ChangeNotifier {
  InternetService service;
  String statsOf;
  Stats gloablstats;
  bool fetching = false;
  List<Country> countriesList = [];

  StatsProvider() {
    service = InternetService();
    fetchMeta();
    fetchCountries();
  }
  String errMsg;

  // void search(query) {
  //   if (query.contains('')) {
  //     filteredSearchList = countriesList.countries;
  //   }
  //   filteredSearchList = countriesList.countries.where((test) {
  //     if (test.contains(query))
  //       return true;
  //     else
  //       return false;
  //   }).toList();
  // }

  Future<void> fetchMeta() async {
    try {
      statsOf = 'Global';
      fetching = true;
      notifyListeners();

      gloablstats = await service.getGlobalDailyStats();

      errMsg = null;
      fetching = false;
      notifyListeners();
    } catch (e) {
      fetching = false;
      errMsg = e.toString().replaceAll("Exception:", '');
      notifyListeners();
    }
  }

  Future fetchCountries() async {
    try {
      fetching = true;
      notifyListeners();

      countriesList = await service.getCountries();
      errMsg = null;
      fetching = false;
      notifyListeners();
    } catch (e) {
      fetching = false;
      errMsg = e.toString().replaceAll("Exception:", '');
      notifyListeners();
    }
  }

  fetchDetailForThisCountry(String iso, String country) async {
    statsOf = country;
    try {
      fetching = true;
      notifyListeners();

      gloablstats = await service.getStatForCountry(iso);

      errMsg = null;
      fetching = false;
      notifyListeners();
    } catch (e) {
      fetching = false;
      errMsg = e.toString().replaceAll("Exception:", '');
      notifyListeners();
    }
  }

  List<charts.Series<LinearCovid, String>> createPieData() {
    final data = [
      LinearCovid('Confirmed', gloablstats.confirmed),
      LinearCovid('Recovered', gloablstats.recoverd),
      LinearCovid('Deaths', gloablstats.deaths),
    ];
    return [
      new charts.Series<LinearCovid, String>(
        id: 'covid-19',
        outsideLabelStyleAccessorFn: (LinearCovid l, _) => charts.TextStyleSpec(
          color: charts.Color(r: 255, g: 255, b: 255),
        ),
        colorFn: (LinearCovid l, i) {
          if (i == 0) return charts.Color(r: 242, g: 185, b: 3);
          if (i == 1) return charts.Color(r: 0, g: 128, b: 0);
          return charts.Color(r: 255, g: 0, b: 0);
        },
        labelAccessorFn: (LinearCovid l, _) => '',
        // overlaySeries: true,

        insideLabelStyleAccessorFn: (LinearCovid l, _) =>
            charts.TextStyleSpec(color: charts.Color(r: 0, g: 0, b: 0)),
        // fillColorFn: (LinearCovid l, _) =>
        //     charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearCovid l, _) => l.legendText,
        measureFn: (LinearCovid l, _) => l.data,
        data: data,
        // Set a label accessor to control the text of the arc label.
        //labelAccessorFn: (LinearCovid stats, _) =>
        //  '${stats.legendText}: ${stats.data}',
      )
    ];
  }
}

class LinearCovid {
  final String legendText;
  final int data;

  LinearCovid(this.legendText, this.data);
}

class Stats {
  int confirmed;
  int deaths;
  int recoverd;
  String lastUpadte;
  String recoveryRate = '0';
  String fatalityRate = '0';

  Stats({this.confirmed, this.deaths, this.recoverd});

  Stats.fromServiceApi(parsedJson) {
    try {
      confirmed = parsedJson["confirmed"]["value"];
      deaths = parsedJson["deaths"]["value"];
      recoverd = parsedJson["recovered"]["value"];
      lastUpadte = parsedJson["lastUpdate"];
      final currenTime = DateTime.now();
      final f = DateTime.parse(lastUpadte);
      // print("${currenTime.toIso8601String()}::::" + "${f.toIso8601String()}");
      // //print(currenTime.difference(currenTime));
      // print(currenTime.difference(f).inHours);
      lastUpadte = currenTime.difference(f).inHours.toString();

      if ((confirmed != null && confirmed != 0) &&
          deaths != null &&
          recoverd != null) {
        recoveryRate = "${((recoverd / confirmed) * 100).toStringAsFixed(2)} %";
        fatalityRate = "${((deaths / confirmed) * 100).toStringAsFixed(2)} %";
      }
      //lastUpadte = parsedJson["lastUpdate"];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

class Country {
  String iso;
  String name;
  String iso3;

  Country.fromServiceApi(parsedJson) {
    //!countryIso = parsedJson;
    //!countries = countryIso["countries"].keys.toList();
    //!countryIso["countries"].forEach((country) {});
    //!deprecated code
    try {
      if (parsedJson["name"] != null) {
        name = parsedJson["name"];
        iso = parsedJson["iso2"];
        iso3 = parsedJson["iso3"];
      }
    } catch (e) {
      print(e.toString());
      throw (e.toString());
    }
  }
  Country.fromDeathToll(parsedJson) {
    //!countryIso = parsedJson;
    //!countries = countryIso["countries"].keys.toList();
    //!countryIso["countries"].forEach((country) {});
    //!deprecated code
    try {
      if (parsedJson["countryRegion"] != null) {
        name = parsedJson["countryRegion"];
        iso = parsedJson["iso2"];
        iso3 = parsedJson["iso3"];
      }
    } catch (e) {
      print(e.toString());
      throw (e.toString());
    }
  }
}
