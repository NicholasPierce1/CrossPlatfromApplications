import 'package:flutter/material.dart';

import 'answers.dart';

// creates a class that'll define a question
class Question{

  // enuemrates instance state
  final String text;
  final List<Answer> answers;

  // canoicallized constructor for rendering a question
  const Question({@required this.text, @required this.answers});

}

