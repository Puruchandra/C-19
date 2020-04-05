import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:corona_stats/models/stats.dart';
import 'package:corona_stats/services/service.dart';

abstract class BaseService {
  Future getGlobalStats();

  Future getGlobalDailyStats();

  Future getGlobalStatForDate();

  Future getCountries();

  Future getGlobalDeathsToll();

  Future getStatForCountry(String iso);
}

class InternetService implements BaseService {
  static final InternetService internetService = InternetService._internal();
  factory InternetService() {
    return internetService;
  }
  InternetService._internal();

  BaseService _service = Service();

  @override
  Future getCountries() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        return await _service.getCountries();
      }
    } on SocketException catch (_) {
      throw Exception('No Internet Connection!');
    }
    return null;
  }

  @override
  Future<Stats> getGlobalDailyStats() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        return await _service.getGlobalDailyStats();
      }
    } on SocketException catch (_) {
      throw Exception('No Internet Connection!');
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
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        return await _service.getStatForCountry(iso);
      }
    } on SocketException catch (_) {
      throw Exception('No Internet Connection!');
    }
    return null;
  }

  @override
  Future getGlobalDeathsToll() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        return await _service.getGlobalDeathsToll();
      }
    } catch (e) {
      throw e;
    }
    return null;
  }
}
