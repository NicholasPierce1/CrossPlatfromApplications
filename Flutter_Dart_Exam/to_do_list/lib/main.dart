import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:to_do_list/toDo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoWidgetState(title: 'Flutter Demo Home Page'),
    );
  }
}

class ToDoWidgetState extends StatefulWidget {
  ToDoWidgetState({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ToDoWidget createState() => _ToDoWidget();
}

class _ToDoWidget extends State<ToDoWidgetState> {
  // renders a list to contain to do objects
  List<ToDo> pendingTask;

  // holds user input
  String _userInput;

  // creates scaffold key
  final GlobalKey scaffoldKey = GlobalKey();

  // overrides init to initialize list
  @override
  void initState() {
    super.initState();

    this.pendingTask = [ToDo(task: "finish this app!"), ToDo(task: "test app")];
  }

  @override
  Widget build(BuildContext context) {
    log("view made");
    // creates a no header page comprised of (sizedbox-col [Row [text], Row [ListView], Row [RaisedButton] ])
    return Scaffold(
        key: this.scaffoldKey,
        appBar: AppBar(),
        body: SizedBox.expand(
            child: Column(
          // enjoins flex to be max-sized and aligns elements at top-left
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,

          // children shall be numerous rows retaining the composite elements comprising this view
          children: <Widget>[
            // first row ( text )
            Row(
              // enjoins flex to be max-sized and align text to center
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

              // child is an expanded-flex container to grow to row's main-axis limit
              children: <Widget>[
                // expanded with a container and text (lg and bold) w/ center alignment
                Expanded(
                    child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text("To-Do List",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)))),
              ],
            ),

            // second row ( ListView constructed off of to do list member w/ thin, black dividers)
            Expanded(
                child: ListView.separated(

                    // each item is a container that wraps a list tile with text as header only
                    itemBuilder: (context, i) {
                      // if index is equal to list's size then create textfield
                      if (this._isSecondToLastIndex(i))
                        return Padding( child: this._createTextField(), padding: EdgeInsets.only(top: 5, left: 3, right: 3));

                      // else if index is equal to list's size then create raised button
                      else if (this._isLastIndex(i))
                        return this._createWrappedRaisedButtonForSubmittingNewTask();

                      return Container(

                          // sets alignment to invoke expansion of container
                          alignment: AlignmentDirectional.center,
                          child: ListTile(

                              // sets the on tap gesture to amend the task's completion status
                              onTap: () => this._changeCompletionStatus(
                                  task: this.pendingTask[i]),
                              title: Text(this.pendingTask[i].task)),

                          // sets its color according torwards the task's completion status
                          color: Colors.green);
                    },
                    separatorBuilder: (context, i) =>
                        !(i < this.pendingTask.length - 1)
                            ? Divider(thickness: 0, height: 0)
                            : Divider(thickness: 1, height: 0, color: Colors.red),

                    // + 2 for textfield and button exclusively
                    itemCount: this.pendingTask.length + 2)),
          ],
        )));
  }

  /* helper method to return the corresponding color per the task's completion status
  Color _setTaskColor({@required ToDo task}) {
    // defines local const memebers to indicate the complete and incomplete colors
    const Color completeColor = Colors.green;
    const Color incompleteColor = Colors.white10;

    return task.isComplete ? completeColor : incompleteColor;
  } */

  // helper method to determine if the index is the last position (over list's size)
  bool _isLastIndex(int index) => index == this.pendingTask.length + 1;

  // helper metod to determine if the index is the second to last (over list's size)
  bool _isSecondToLastIndex(int index) => index == this.pendingTask.length;

  // helper method to create a textfield
  TextField _createTextField() => TextField(
        // on change updates user input memeber
        onChanged: (userInput) => this._userInput = userInput,

        // creates decoration for input field
        decoration: InputDecoration(

            // sets helper and label text
            labelText: "New to-do",

            // creates an input border the color of the widget's primary-theme color
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1))),
      );

  // helper method to that, when a tap occurs on a list tile (task) the color/completion status is flipped and a redraw transpires
  void _changeCompletionStatus({@required ToDo task}) =>
      this.setState(() => task.changeToDoCompletionStatus());

  // helper method to handle what occurs when the user submits a task
  // sets the on submit -- (if non empty, then add to task list and set state, else then raise a snackbar message)
  void _validateAndCreateNewTask() {
    // checks if nonempty
    if (_userInput == null || _userInput.isEmpty) {
      log("empty");

      // acquires scaffold state from key
      final ScaffoldState scaffold = this.scaffoldKey.currentState;

      // renders snack backbar
      scaffold
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          key: GlobalKey(),
          content: Text("input cannot be empty"),
          duration: Duration(seconds: 3),
          onVisible: () => log("visible"),
        ));

      // exits process
      return;
    }

    // appends task and sets state
    this.setState(() {
      // appends new task to pending task
      this.pendingTask.add(ToDo(task: _userInput));

      // clears user input
      this._userInput = "";
    });
  }

  // helper method to create raise button
  Container _createWrappedRaisedButtonForSubmittingNewTask() => Container(  
    margin: EdgeInsets.only(left: 110, right: 110), 
    child: RaisedButton(
        child: Text(
          "Add To-Do",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),

        // sets its on click listener to helper method to create new task conditionally
        onPressed: () => this._validateAndCreateNewTask(),
      ));
}
