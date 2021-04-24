// defines if an answer is correct
import 'package:flutter/material.dart';

enum AnswerType{correct, incorrect}

// creates a class that'll define an answered to be tailored to a question
class Answer{

  // enumerates member state
  final String answerText;
  final AnswerType answerType;

  // canoicallized constructor
  const Answer({@required this.answerText,@required this.answerType});
}