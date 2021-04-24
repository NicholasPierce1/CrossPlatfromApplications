import 'package:flutter/material.dart';
import 'answers.dart';
import 'question.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: MyHomePage(title: 'A Fine and Noble Quiz'),
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
  @override
  Widget build(BuildContext context) {
    // creates local ref to a question
    final Question question =
        const Question(text: "What is the meaning of life?", answers: <Answer>[
      const Answer(answerText: "a) to flex on your haters", answerType: AnswerType.incorrect),
      const Answer(
          answerText: "b) to pursue happiness", answerType: AnswerType.correct),
      const Answer(answerText: "c) money", answerType: AnswerType.incorrect),
    ]);

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Container( child: Text(widget.title), alignment: AlignmentDirectional.center)
        ),

        // creates subtree as follows (sizedbox - col[text, listview])
        body: SizedBox.expand(

            // creates a col that's centered expands to parent's dimensions
            child: Column(
          // max size on main axis and positioned top-center
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          // children [text and listview]
          children: <Widget>[
            // text
            Text("A Querlous Quiz",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700)),

            // an expanded wrapped in a Listview, comprised of ListTiles - that'll display the question and answers
            Expanded(
                flex: 7,
                child: ListView.builder(
                    itemBuilder: (context, i) {
                      // if i is 0, then return the text containing the question
                      if (i == 0)
                        return Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(question.text,
                                style: TextStyle(
                                    fontSize: 25, fontStyle: FontStyle.italic)),
                            alignment: AlignmentDirectional.bottomCenter,
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black))));

                      // creates a list tile comprised of a leaning checkbox and a text of the question
                      return ListTile(
                        leading: Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(0),
                            child: Checkbox(
                                value: false, onChanged: (newValue) {})),
                        title: Text(question.answers[i - 1].answerText),
                      );
                    },
                    itemCount: question.answers.length + 1)),

            // pads with spacer
            Spacer(flex: 1),

            // creates a row to contain the submit button
            Expanded(
              flex: 1,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // creates new button
                  Expanded(
                      child: RaisedButton(
                          color: Colors.orange[300],
                          child: Text("Submit",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.white)),
                          onPressed: () {}))
                ],
              ),
            ),

            // pads with spacer to occupy remaining space
            Spacer(flex: 8)
          ],
        )));
  }
}
