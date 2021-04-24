import 'package:flutter/material.dart';

// file to hold sub-widget tree for favorite icon + de/incrementor
class FavoriteWidget extends StatefulWidget {
  // overrides required method to return State obtaining the widget tree
  @override
  FavoriteWidgetTree createState() => new FavoriteWidgetTree();
}

class FavoriteWidgetTree extends State<FavoriteWidget> {
  // state members to denote the fav_count and if it is favorite
  bool _isFavorite = true;
  int _favCount = 41;

  // renders sub-widget tree comprised of flex box retaining an icon button and a text
  @override
  Widget build(BuildContext context) {
    // creates row, taking minimum main-axis space
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // creates icon button
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorite ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: () => _changeFavoriteState(),
          ),
        ),

        // creates text to display fav count
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favCount'),
          ),
        ),
      ],
    );
  }

  // invokes when user toggles fav_icon -- will incremented and change star picture varying on current state
  void _changeFavoriteState() {
    this.setState(() {
      if (_isFavorite) {
        // decrement counter and set is fav to false (no longer favorite)
        this._isFavorite = false;
        --this._favCount;
      } else {
        // increment counter and set is fav to true
        this._isFavorite = true;
        ++this._favCount;
      }
    });
  }
}
