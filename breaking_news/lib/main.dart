import 'package:breaking_news/addANewStory.dart';
import 'package:breaking_news/detailsScreen.dart';
import 'package:flutter/material.dart';

import 'newsModel.dart';

// main-root route to render an app bar to permit appending new stories coupled with a listview of current stories
// that'll permit you to view their details
void main() => runApp(MaterialApp(

        // sets title
        title: "News Article",
        theme: ThemeData(primaryColor: Colors.blue[800]),
        initialRoute: "/",
        routes: {
          // home-root route
          ShowStories.homeRouteString: (context) => ShowStories(),
          DetailsScreen.detailsScreenRoute: (context) => DetailsScreen(),
          AddNewStory.addNewStoryRoute: (context) => AddNewStory()
        }));

class ShowStories extends StatefulWidget {
  static const String homeRouteString = "/";

  @override
  ShowStoriesState createState() => ShowStoriesState();
}

class ShowStoriesState extends State<ShowStories> {
  @override
  // creates an app bar w/ navigation functionality and list view to navigate torwards a details page
  Widget build(BuildContext context) {
    // local ref to list-model
    final List<NewsStories> newsStories = NewsStories.getCurrentStories();

    return Scaffold(
        appBar: AppBar(
          title: Text("News Stories"),

          // one action to navigate to create new stories page
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.forward),
              onPressed: () => this._transitionToAddStoryAndUpdate(),
            )
          ],
        ),

        // creates list view that derivied of news story articles
        body: ListView.separated(
            itemCount: newsStories.length,
            itemBuilder: (context, index) {
              // local ref to story
              final NewsStories story = newsStories[index];

              // creates list tile, invoking various state input
              return ListTile(
                title: Text(story.header),

                // on press listener to segue to details page w/ selected news story
                onTap: () => Navigator.pushNamed<void>(
                    context, DetailsScreen.detailsScreenRoute,
                    arguments: story),
              );
            },
            separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                  thickness: 1,
                )));
  }

  // local, async method to transition to view and invoke a setstate for a redraw
  void _transitionToAddStoryAndUpdate() async {
    // segues to add new story, waiting for pop, disregarding future
    await Navigator.pushNamed<void>(context, AddNewStory.addNewStoryRoute);

    // invokes set state-- no actions/updates transpire due to model class retaining state
    this.setState(() {});
  }
}
