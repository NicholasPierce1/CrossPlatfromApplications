// enum for denoting whether a task is complete
import 'package:flutter/cupertino.dart';

enum ToDoCompletionStatus { complete, incomplete }

// class that renders the definition of to do type of task
class ToDo {
  // enumerates instance memebers
  final String task;
  ToDoCompletionStatus _completionStatus;

  // defines a getter for indicating if an object is complete
  bool get isComplete {
    return this._completionStatus == ToDoCompletionStatus.complete;
  }

  // creates a private setter that, according of the boolean, changes the completion status of the task
  set _isComplete(final bool isComplete) {
    this._completionStatus = isComplete
        ? ToDoCompletionStatus.complete
        : ToDoCompletionStatus.incomplete;
  }

  // constructor for creating a task w/ pre-defined set of completion status
  ToDo({@required this.task})
      : _completionStatus = ToDoCompletionStatus.incomplete;

  // changes a ToDo's completion status (false -> true) and converse
  void changeToDoCompletionStatus() => this._isComplete = !this.isComplete;
}
