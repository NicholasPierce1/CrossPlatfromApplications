// creates a class to simulate a game, adding random numbers to each player until the score-threshold is reached

// 3a)
import 'dart:math';

import 'package:exam0/game.dart';

class GameSimulator {
  // 3a) continued
  // enumerates instance memebers
  int winningScore = 0; // init to 0
  List<Player> players = []; // init to list

  // 3b)
  // base constructor that accepts an int to denote the target score
  GameSimulator({this.winningScore});

  // 3c)
  // creates the number of players, randomly choosing a name from a local list + 0 score + 100 health
  // add random score from [0, winningScore/2], return player that reaches winning score first
  Player playGame({int numOfPlayers = 4}) {
    // defines local list
    final  namePossibilities = [
      'Beyonce',
      'Elvis Presley',
      'Lady Gaga',
      'Ariana Grande',
      'Adele',
      'Taylor Swift'
    ];

    // random num gen to to be used to acquire a player's name and their random score
    final randumNumGen = Random();

    // creates a local list of players - init with size of target players
    final players = List<Player>(numOfPlayers);

    // creates local member to denote iteration when a player has reached target score
    Player winnerPlayer;

    // iterates through target num of players, adding the player w/ aforementioned attributes (name, score, hp)
    for (var i = 0; i < numOfPlayers; i++) {
      players[i] = Player(
          namePossibilities[randumNumGen.nextInt(namePossibilities.length)],
          0,
          100);
    }

    // while no player has reached target score, accrue player's score by num between [0, winningScore/2]
    while (winnerPlayer == null) {
      // walks through all players, when one reaches score, return that player
      for (final player in players) {
        // adds to player's score - by the floor of half the winning number. ex: 11/2 + 1 => 6 exclusive
        player.addScoreBy(
            randumNumGen.nextInt((winningScore / 2).floor() + 1));

        // if player's score > winningScore, then set that player as the winning player
        if (player.score >= winningScore) {
          winnerPlayer = player;
        }
      }
    }

    // returns winning player
    return winnerPlayer;
  }
}
