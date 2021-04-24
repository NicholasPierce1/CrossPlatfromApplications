// 1)

// 1a)
// creates definiton for a player
class Player {
  // 1a) continued
  // enumerate memeber state
  String name;
  int score;
  int healtPoints;

  // defines static var to hold the number of players
  static final int _numPlayers = 0;

  // 1b)
  // no-body constructor to create player
  Player(this.name, this.score, this.healtPoints);

  // 1c)
  // named-constructor for creation of boss (no-arg)
  Player.boss()
      : name = 'Boss',
        score = 0,
        healtPoints = 1000;

  // 1d)
  // overrides to string print to print as follows (name: x score: x healthPoints: x)
  @override
  String toString() {
    return 'Name: ${name} Score: ${score} HealthPoints: ${healtPoints}';
  }

  // 1e)
  // public method to accrue score by a non-neg score (exit if negative)
  void addScoreBy(int scoreToAddBy) {
    // if neg- exit
    if (scoreToAddBy < 0) return;

    // appends score to player's current score
    score += scoreToAddBy;
  }
}
