import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// PURPOSE: Converts Euros to Dollars!
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Euro Conversion',
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
      home: MyHomePage(
        title: 'Euro Conversion',
        primaryThemeColor: Colors.blue[500],
    
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // overrides to supplement primary-theme color data
  final Color primaryThemeColor;

  MyHomePage({Key key, this.primaryThemeColor, this.title}) : super(key: key);

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
  // prefix-const for dollar convereter
  static const String _dollarPrefix = '\$';

  // holds state for euro input
  double _euroInput = 0;

  // member holding conversion rate
  double _conversionRate = 1.11;

  // holds length rate to fluctuate varying on instigating input
  int lengthLimitToEuroInput = 5;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          backgroundColor: widget.primaryThemeColor,
        ),

        // creates a collumn that contains a header text, textfield input, and a text
        body: new Column(

            // expands to parent's parameters and starts all children at the left
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            // contains a header text, textfield input, and a text
            children: <Widget>[
              // creates header text w/ styling
              new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("${widget.title}",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: widget.primaryThemeColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold))
                  ]),

              // row- expanded- col- container(pading- textfield) & container(text)
              new Row(

                  // row expands to max size provided by bounded-parent constraints & will start on the left
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // expands its flex-widget child to its parent's main-axis dimension
                    Expanded(
                        child: new Column(

                            // all children widgets will be placed on the topmost-left
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                          // holds a padding container that'll hold the textfield
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding:
                                      new EdgeInsets.only(left: 15, right: 15),
                                  child: TextField(
                                    // constrains input to numerical w/ floating points
                                    keyboardType: TextInputType.number,
                                    maxLength: this.lengthLimitToEuroInput,
                                    maxLengthEnforced: true,

                                    // sets border decoration that'll be a thin-blue border (when focused) with 'euro' help text
                                    decoration: InputDecoration(
                                        hintText: "Euro",
                                        labelText: "Euro",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: widget.primaryThemeColor,
                                                width: 1,
                                                style: BorderStyle.solid))),

                                    // sets the onChange field to invoke instance-function to update state of dollar conversion
                                    onChanged: (euroText) => this
                                        ._updateConversionText(
                                            euroText: euroText),
                                  ))),

                          Container(
                              alignment: Alignment.center,
                              child: Text(this._setDollarText()))
                        ]))
                  ])
            ]));
  }

  // private method to validate, and conditionally update, dollar-conversion state
  void _updateConversionText({@required String euroText}) {
    this.setState(() { 
      // if input is empty, set euro input to 0
      if (euroText.isEmpty)
        this._euroInput = 0;
      else // given text is numerical type
      {
        if (!(euroText.length >= 4 && euroText[0] == '.')) {
          // valid input handler
          this._euroInput = double.parse(euroText);
          this.lengthLimitToEuroInput = 5;
        } else // exhasuted floating-point length -> reset string to omit 4th char
          this.lengthLimitToEuroInput = 3;
      }
    });
  }

  // takes in euro input - if non-empty and sets its conversion
  String _setDollarText() {
    if (this._euroInput == 0)
      return "Dollars: ${_MyHomePageState._dollarPrefix}";
    else // sets text to conversion of euro input w/ 2 floating points
      return "Dollars: ${_MyHomePageState._dollarPrefix} ${(this._euroInput * this._conversionRate).toStringAsFixed(2)}";
  }
}
