import 'package:flutter/material.dart';
import 'package:layout_tutorial/favoriteWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter layout demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// sets a color for text color to be configured to
  static final Color textColor = Colors.orange;

  @override
  Widget build(BuildContext context) {
    // renders composite row of title sections to be comprised in flex-collumn later
    final Widget titleSection = new Container(
        padding: new EdgeInsets.only(bottom: 32),

        // creates a row which will be comprised of (container, Icon, and Text)
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // creates expanded that'll be comprised of two text values wrapped in a column
              new Expanded(
                  child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // evens out spaces between children elements w/o space at start and end
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                // creates two text views
                children: <Widget>[
                  // container which will be comprised of expanded
                  new Container(
                      padding: new EdgeInsets.only(bottom: 8),
                      // creates Text view 1
                      child: new Text('Oeschinen Lake Campground',
                          style: new TextStyle(
                              color: _MyHomePageState.textColor,
                              fontWeight: FontWeight.bold))),

                  // creates Text  view 2
                  new Text('Kandersteg, Switzerland',
                      style: new TextStyle(
                          color: Colors.grey[500], fontWeight: FontWeight.bold))
                ],
              )),

              // row element two (favorite widget)
              new FavoriteWidget()
            ]));

    // acquires a theme from the build context
    final ThemeData themeOfContext = Theme.of(context);

    // acuires primary color (set or default)
    final Color primaryColor = themeOfContext.colorScheme.primary;

    // renders icon-row section comprised of three columns
    final Row iconRowSection = new Row(
      // spaces elements evenly w/ space start & back
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: <Widget>[
        _renderColumnForIconAndText(
            colorOfIcon: primaryColor,
            iconData: Icons.call,
            labelString: 'CALL'),
        _renderColumnForIconAndText(
            colorOfIcon: primaryColor,
            iconData: Icons.near_me,
            labelString: 'ROUTE'),
        _renderColumnForIconAndText(
            colorOfIcon: primaryColor,
            iconData: Icons.share,
            labelString: 'SHARE')
      ],
    );

    // third row section: text sections
    final Container textSection = new Container(
        padding: new EdgeInsets.all(32),
        child: Text(
            'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',

            // invokes soft wrap to instruct flex container to wrap text to end of width before traverssing to next line
            softWrap: true,
            style: new TextStyle(
                color: _MyHomePageState.textColor,
                fontSize: 12,
                fontWeight: FontWeight.normal)));

    // creates image
    final Image image = new Image.asset('lib/ImageAssets/lake.jpg',
        width: 600, height: 250, fit: BoxFit.cover);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      /*
      body: ListView(
        padding: new EdgeInsets.only(top: 0),
        children: <Widget>[image, titleSection, iconRowSection, textSection],
      ),*/
      body: new ListView.builder(
        padding: new EdgeInsets.only(top: 0),
        itemCount: 4,
        itemBuilder: (context, index){
          switch(index){
            case 0:
              return image;
              break;
            case 1:
              return titleSection;
              break;
            case 3:
              return iconRowSection;
              break;
            default: // always 3
            return textSection;
            break;
          }
        }
      )
    );
  }

  /* for implementation of row two, a local method will return col embedded with an icon and text */
  Column _renderColumnForIconAndText(
          {final IconData iconData,
          final String labelString,
          final Color colorOfIcon}) =>
      new Column(
        // main axis's size shall fill only space of children
        mainAxisSize: MainAxisSize.min,

        // elements begin at center of axis
        mainAxisAlignment: MainAxisAlignment.center,

        // children comprised of an icon and text
        children: <Widget>[
          // icon
          new Icon(iconData, color: colorOfIcon),

          // text
          new Text(labelString,
              style: new TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: colorOfIcon,
              ))
        ],
      );
}
