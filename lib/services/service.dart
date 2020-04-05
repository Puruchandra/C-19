//* API DOCS
// ?  /: contains opengraph image for sharing

//? /api: global summary

//? /api/og: generate a summary open graph image

//? /api/confirmed: global cases per region sorted by confirmed cases

//? /api/recovered: global cases per region sorted by recovered cases

//? /api/deaths: global cases per region sorted by death toll

//? /api/daily: global cases per day

//? /api/daily/[date]: detail of updates in a [date] (e.g. /api/daily/2-14-2020)

//? /api/countries: all countries and their ISO codes

//? /api/countries/[country]: a [country] summary (e.g. /api/countries/Indonesia or /api/countries/USA or /api/countries/CN)

//? /api/countries/[country]/confirmed: a [country] cases per region sorted by confirmed cases

//? /api/countries/[country]/recovered: a [country] cases per region sorted by recovered cases

//? /api/countries/[country]/deaths: a [country] cases per region sorted by death toll

//? /api/countries/[country]/og: generate a summary open graph image for a [country]

import 'dart:convert';

import 'package:corona_stats/models/death_toll.dart';
import 'package:corona_stats/models/stats.dart';
import 'package:corona_stats/services/index.dart';
import 'package:http/http.dart' as http;

class Service implements BaseService {
  static final Service service = Service._internal();
  factory Service() {
    return service;
  }
  Service._internal();

  String baseUrl = 'https://covid19.mathdro.id/';

  @override
  Future<List<Country>> getCountries() async {
    try {
      List<Country> _countries = [];
      var response = await http.get(baseUrl + 'api/countries');
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        json["countries"].forEach((country) {
          _countries.add(Country.fromServiceApi(country));
        });
        print(_countries[0]);
        return _countries;
      }
      if (response.statusCode == 404) {
        throw Exception("Not Found");
      }
    } catch (e) {
      print.toString();
      throw Exception(e.toString());
    }

    return null;
  }

  @override
  Future<Stats> getGlobalDailyStats() async {
    try {
      var response = await http.get(baseUrl + 'api');
      if (response.statusCode == 200) {
        return Stats.fromServiceApi(jsonDecode(response.body));
      }
      if (response.statusCode == 404) {
        throw Exception("Not Found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    return null;
  }

  @override
  Future getGlobalStatForDate() {
    // TODO: implement getGlobalStatForDate
    return null;
  }

  @override
  Future getGlobalStats() {
    // TODO: implement getGlobalStats
    return null;
  }

  @override
  Future getStatForCountry(String iso) async {
    try {
      var response = await http.get(baseUrl + 'api/countries/$iso');
      if (response.statusCode == 200) {
        return Stats.fromServiceApi(jsonDecode(response.body));
      }
      if (response.statusCode == 404) {
        throw Exception("Not Found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    return null;
  }

  @override
  Future getGlobalDeathsToll() async {
    try {
      List<DeathToll> _globalDeathTolls = [];
      var response = await http.get(baseUrl + 'api/deaths');
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        json.takeWhile((val) => _globalDeathTolls.length < 20).forEach((item) {
          _globalDeathTolls.add(DeathToll.fromApiResponse(item));
        });
        return _globalDeathTolls;
      }
      if (response.statusCode == 404) {
        throw Exception("Not Found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }
}
