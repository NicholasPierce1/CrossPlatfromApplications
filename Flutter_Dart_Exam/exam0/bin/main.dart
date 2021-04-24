import 'package:exam0/gameSimulator.dart';
import 'package:exam0/randomList.dart';

void main(List<String> arguments) {
  // 0) verifiable prints for question 0
  print('question 0 - case 1: ${randomList(length: 10, from: 1, to: 6)}');
  print('question 0 - case 2: ${randomList(length: 10, from: 6, to: 1)}');
  print('question 0 - case 3: ${randomList()}\n');

  // 3d) verifiable prints for question 3 for game simulator

  // creates gaame sim with winning score of 100
  final gameSim = GameSimulator(winningScore: 100);

  // acquires player that won randomly of 4 player
  final winner = gameSim.playGame(numOfPlayers: 4);

  // formatted print, showing the winner's name
  print('Congratulations, ${winner.name}, you won');
}
