import 'package:corona_stats/models/death_toll.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  final DeathTollProvider model;
  CustomBottomSheet({this.model});
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        color: Color(0xff1b232f),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.drag_handle, color: Colors.white),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, i) => Container(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: Color(0xff1b232f),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.model.deathTollList[i].country.name,
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Deaths: ${widget.model.deathTollList[i].stats.deaths}',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  )
                  // : Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: children,
                  //   ),
                  ),

              // ListTile(
              //   leading: Text(widget.model.deathTollList[i].country.name),
              //   subtitle: RichText(
              //     text: TextSpan(children: [
              //       TextSpan(
              //         text:
              //             'Confirmed ${widget.model.deathTollList[i].stats.confirmed}\n',
              //         style: TextStyle(color: Colors.black),
              //       ),
              //       TextSpan(
              //         text:
              //             'Recoverd ${widget.model.deathTollList[i].stats.recoverd}\n',
              //         style: TextStyle(color: Colors.black),
              //       ),
              //       TextSpan(
              //         text:
              //             'Deaths ${widget.model.deathTollList[i].stats.deaths}',
              //         style: TextStyle(color: Colors.black),
              //       ),
              //     ]),
              //   ),
              //   onTap:
              //       //widget.model.deathTollList[i].country.iso != null
              //       // ? () {
              //       //     widget.model.fetchDetailForThisCountry(
              //       //         widget.model.deathTollList[i].country.iso,
              //       //         widget.model.deathTollList[i].country.name);
              //       //     Navigator.pop(context);
              //       //   }
              //       ///:
              //       null,
              // ),
              itemCount: widget.model.deathTollList.length,
            ),
          ),
        ],
      ),
    );
  }
}
