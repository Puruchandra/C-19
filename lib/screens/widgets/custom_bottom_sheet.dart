import 'package:corona_stats/models/stats.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  final StatsProvider model;
  CustomBottomSheet({this.model});
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildTextField(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, i) => ListTile(
                leading: Text(widget.model.countriesList[i].name),
                onTap: widget.model.countriesList[i].iso != null
                    ? () {
                        widget.model.fetchDetailForThisCountry(
                            widget.model.countriesList[i].iso,
                            widget.model.countriesList[i].name);
                        Navigator.pop(context);
                      }
                    : null,
              ),
              itemCount: widget.model.countriesList.length,
            ),
          ),
        ],
      ),
    );
  }

  buildTextField() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      child: TextField(
        decoration: InputDecoration(
            enabled: false,
            hintText: 'India',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
            labelText: 'Search'),
        onSubmitted: (value) {
          //print(value);
          //widget.model.search(value.toLowerCase());
        },
      ),
    );
  }
}
