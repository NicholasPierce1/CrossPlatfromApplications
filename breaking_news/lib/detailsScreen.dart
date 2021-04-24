// creates a stateless widget that accepts modal input as a NewsStories and displays composite input into texts
import 'package:breaking_news/newsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  static const String detailsScreenRoute = "/detailScreen";

  DetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    // acquires passed new stories arg
    final NewsStories storyToDisplay =
        this._getNewsStoryFromModal(buildContext);

    return new Scaffold(

        // back button already provided
        appBar: AppBar(title: new Text(storyToDisplay.header)),
        body: new Row(
          // sets main axis to occupy parent and positions children at top-left
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,

          // children comprised of: expanded- col - texts
          children: <Widget>[
            // expanded
            new Expanded(

                // creates col to hold all story memebers
                child: new Column(
              // enjoins to be full size on main axis starting at center of main, left of cross
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,

              // children of texts
              children: <Widget>[
                // header
                Padding(
                    child: new Text(storyToDisplay.header,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    padding: EdgeInsets.only(bottom: 10)),

                // byline (left)
                Container(
                  child: new Text(storyToDisplay.byLine,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[500])),
                  padding: EdgeInsets.only(bottom: 5),
                  alignment: Alignment.centerLeft,
                ),

                // body (justify)
                Container(
                  child: new Text(storyToDisplay.body,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 12)),
                  padding: EdgeInsets.only(bottom: 5),
                  alignment: Alignment.centerLeft,
                ),

                // date
                Padding(
                    child: new Text(
                        storyToDisplay.dateOfStory.toLocal().toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[500])),
                    padding: EdgeInsets.only(bottom: 10)),

                // EXTRA CREDIT: insert news image logo that covers entire width
                Row(
                  // sets main axis's bounds to expand to parent
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,

                  // renders one child (expanded) to assume image widget
                  children: <Widget>[
                    // creates expanded to hold img
                    Expanded(child: Image.asset("lib/assets/logo.png"))
                  ],
                )
              ],
            ))
          ],
        ));
  }

  // returns new stories from modal
  NewsStories _getNewsStoryFromModal(BuildContext context) =>
      ModalRoute.of(context).settings.arguments as NewsStories;
}
