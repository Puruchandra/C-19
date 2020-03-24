import 'package:corona_stats/models/stats.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieCard extends StatelessWidget {
  final StatsProvider model;

  PieCard({this.model});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
            color: Color(0xff1b232f),
            borderRadius: BorderRadius.circular(10.0)),
        height: height * 0.45,
        child: charts.PieChart(
          model.createPieData(),
          animate: true,
          behaviors: [
            charts.DatumLegend(
                position: charts.BehaviorPosition.bottom,
                entryTextStyle: charts.TextStyleSpec(
                    color: charts.Color(r: 255, g: 255, b: 255)))
          ],
          defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 40,
            arcRendererDecorators: [new charts.ArcLabelDecorator()],
          ),
        ));
  }
}
