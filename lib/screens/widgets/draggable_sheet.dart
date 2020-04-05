import 'package:flutter/material.dart';

class DraggableSheet extends StatelessWidget {
  final model;

  const DraggableSheet({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.1,
        maxChildSize: 0.8,
        builder: (BuildContext context, myscrollController) {
          return Container(
            color: Colors.tealAccent[200],
            child: ListView.builder(
              itemBuilder: (_, i) => ListTile(
                leading: Text(model.deathTollList[i].country.name),
                subtitle: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text:
                          'Confirmed ${model.deathTollList[i].stats.confirmed}\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text:
                          'Recoverd ${model.deathTollList[i].stats.recoverd}\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Deaths ${model.deathTollList[i].stats.deaths}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ]),
                ),
                onTap:
                    //model.deathTollList[i].country.iso != null
                    // ? () {
                    //     model.fetchDetailForThisCountry(
                    //         model.deathTollList[i].country.iso,
                    //         model.deathTollList[i].country.name);
                    //     Navigator.pop(context);
                    //   }
                    ///:
                    null,
              ),
              itemCount: model.deathTollList.length,
            ),
          );
        },
      ),
    );
  }
}
