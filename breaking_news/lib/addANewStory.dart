// aggregate view comprised of numerous form-textfields that'll render a new newstory
import 'package:breaking_news/newsModel.dart';
import 'package:flutter/material.dart';

class AddNewStory extends StatefulWidget {
  static const String addNewStoryRoute = "/addNewStory";

  @override
  AddNewStoryScreen createState() => AddNewStoryScreen();
}

class AddNewStoryScreen extends State<AddNewStory> {
  // enumerates state members
  String _header;

  String _byLine;

  String _body;

  DateTime _dateOfStory;

  // creates a global key to be tailored to the form's state
  final GlobalKey<FormState> globalFormStateKey = GlobalKey<FormState>();

  // creates global key for scaffold
  final GlobalKey<ScaffoldState> scaffoldGlobalkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // local member ref to self
    final AddNewStoryScreen self = this;

    // creates a form with a raised button
    return new Scaffold(
        key: scaffoldGlobalkey,

        // back button already provided
        appBar: AppBar(title: new Text("Create a New Story")),
        body: new Row(

            // sets main axis to occupy parent and positions children at top-left
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,

            // children comprised of: expanded- col - texts
            children: <Widget>[
              // expanded
              new Expanded(

                  // creates form to integrate column in
                  child: Form(

                      // tethers global key to its form state
                      key: this.globalFormStateKey,

                      // creates col to hold all story memebers
                      child: new Column(

                          // enjoins to be full size on main axis starting at center of main, left of cross
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          // children of textsfields
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(bottom: 10)),

                            for (int i = 0;
                                i < NewStoryInputs.values.length;
                                i++)
                              Padding(
                                  child: AddNewStoryScreen
                                      ._createTextFormFromInputType(
                                          NewStoryInputs.values[i], self),
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10)),

                            // creates a wrapped raised button that conditionally saves the form and appends a new, news-story
                            Row(

                                // exapnds on main axis to parent's bound
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // wraps raised button in expanded
                                  Expanded(
                                      child: RaisedButton(

                                          // color of button's state (focus and hover combined)
                                          color: Theme.of(context).primaryColor,
                                          focusColor: Colors.grey[900],
                                          hoverColor: Colors.grey[900],

                                          // child is comprised of text for submission
                                          child: Text("Submit Story"),

                                          // on press validates and conditionally saves & appends new story
                                          onPressed: () {
                                            // acquires form-state from global key
                                            final FormState formState = this
                                                .globalFormStateKey
                                                .currentState;

                                            // checks for validation of composite input types
                                            if (formState.validate()) {
                                              // valid inputs

                                              // saves inputs to controller-instance
                                              formState.save();

                                              // creates new instance from composite inputs
                                              NewsStories.addAStory(
                                                  header: this._header,
                                                  byLine: this._byLine,
                                                  body: this._body,
                                                  dateTime: this._dateOfStory);

                                              // invokes a reset
                                              formState.reset();

                                              // snackbar to show succession of submission
                                              this
                                                  .scaffoldGlobalkey
                                                  .currentState
                                                ..removeCurrentSnackBar()
                                                ..showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Your story has been saves successfully"),
                                                    duration:
                                                        Duration(seconds: 3)));

                                              // pops to prior view
                                              Navigator.pop<void>(context);
                                            }
                                          }))
                                ]),
                          ])))
            ]));
  }

// local, static method to return a Form-text field varing from a NewStoryInput
  static TextFormField _createTextFormFromInputType(
      NewStoryInputs inputType, AddNewStoryScreen self) {
    // local memeber for helper text
    final String helperText =
        AddNewStoryScreen._getInputHelperTextStringFromInput(inputType);

    // returns a text field with only hint and label text varying on input type
    return TextFormField(
      // if input type is the body, allocate more lines
      maxLines: inputType == NewStoryInputs.body ? 5 : 1,
      decoration: InputDecoration(
          labelText: helperText,
          hintText: helperText,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[500]))),

      // saves local memeber state based off the input type
      onSaved: (valueToSave) => AddNewStoryScreen._saveInputHelperFromInputType(
          inputType, self, valueToSave),

      // validates input by following conditions (if dateTime -- empty or convertable, else -- non-empty)
      validator: (rawInput) {
        // checks if input type is of datetime
        if (inputType == NewStoryInputs.dateOfStory)
          return rawInput.isEmpty || DateTime.tryParse(rawInput) != null
              ? null
              : "please enter a valid date or leave blank";
        else
          return rawInput.isEmpty ? "field cannot be blank" : null;
      },
    );
  }

// local, static method to return the input's helper text from the input type
  static String _getInputHelperTextStringFromInput(NewStoryInputs inputType) {
    switch (inputType) {
      case NewStoryInputs.body:
        return "body";
        break;
      case NewStoryInputs.byLine:
        return "byline";
        break;
      case NewStoryInputs.dateOfStory:
        return "date (blank assumes current date)";
        break;
      default: // always header
        return "header";
        break;
    }
  }

// local, static method to set data of local member type varying on input type
// NOTE: all casting is safe in local env
  static void _saveInputHelperFromInputType(
      NewStoryInputs inputType, AddNewStoryScreen self, String dataToSave) {
    switch (inputType) {
      case NewStoryInputs.body:
        self._body = dataToSave;
        break;
      case NewStoryInputs.byLine:
        self._byLine = dataToSave;
        break;
      case NewStoryInputs.dateOfStory:
        // if the string is empty, then return datetime now, else return formatted date
        self._dateOfStory = DateTime.tryParse(dataToSave) != null
            ? DateTime.tryParse(dataToSave)
            : DateTime.now();
        break;
      case NewStoryInputs.header:
        self._header = dataToSave;
        break;
    }
  }
}
