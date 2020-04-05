import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

class SearchBar extends StatelessWidget {
  final value;
  final Function(dynamic) onItemSelected;

  const SearchBar({Key key, this.value, this.onItemSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFSearchBar(
      searchBoxInputDecoration: InputDecoration(
        // contentPadding: EdgeInsets.only(left: 4.0),
        // labelText: 'Search for Country!',
        // labelStyle: TextStyle(color: Colors.white),
        hintText: '  Search for countries',
        hintStyle: TextStyle(color: Colors.white24),
        fillColor: Color(0xff1b232f),
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.0,
            )),
        suffixIcon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff0F111A),
          ),
          margin: EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0),
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.0,
            )),
      ),
      searchList: value.countriesList,
      searchQueryBuilder: (query, list) {
        return list
            .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      },
      overlaySearchListItemBuilder: (item) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            item.name,
            style: const TextStyle(fontSize: 18),
          ),
        );
      },
      onItemSelected: (item) {
        onItemSelected(item);
      },
    );
  }
}
