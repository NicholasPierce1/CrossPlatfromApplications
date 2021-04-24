// model class to hold and create news stories
import 'package:flutter/cupertino.dart';

class NewsStories {
// static instance to hold a list of new stories with private modifiers
  static final List<NewsStories> currentStories = [];

// enuemrates instance members (public to access externally)
  final String header;

  final String byLine;

  final String body;

  final DateTime dateOfStory;

// renders canoical constructor
  const NewsStories({this.header, this.byLine, this.body, this.dateOfStory});

// static method to return the current list
  static List<NewsStories> getCurrentStories() => NewsStories.currentStories;

// appends a new story with composite inputs
  static void addAStory(
          {@required final String header,
          @required final String byLine,
          @required final String body,
          @required final DateTime dateTime}) =>
      NewsStories.currentStories.add(NewsStories(
          header: header, byLine: byLine, body: body, dateOfStory: dateTime));
}

// enum to hold input cases
enum NewStoryInputs { header, byLine, body, dateOfStory }
