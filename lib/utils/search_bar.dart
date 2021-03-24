import 'package:flutter/material.dart';
import 'package:new_z_tst/constants.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;

  const SearchBar({
    Key key,
    this.enabled = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: kViewTagSearchBar,
      child: Material(
        child: Container(
          height: 60.0,
          padding: EdgeInsets.only(
            left: 10.0,
            top: 5.0,
            bottom: 5.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: TextField(
            autofocus: enabled,
            controller: controller,
            enabled: enabled,
            decoration: InputDecoration(
              prefix: Icon(
                Icons.search,
                color: Colors.white,
              ),
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'Tap to search headlines',
            ),
          ),
        ),
      ),
    );
  }
}
