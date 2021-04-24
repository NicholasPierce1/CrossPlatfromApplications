import 'dart:math';

// 0)
// create a list of random numbers from x to y inclusive of length l
List<int> randomList({int length = 5, int from = 1, int to = 6}) {
  // asserts numbers are non-negative
  assert(length >= 0 && from >= 0 && to >= 0);

  // initializes local- list
  final resultList = List<int>(length);

  // local, final random
  final randomGen = Random();

  // if from is less than to- return null
  if(from > to) return null;

  // constructs a for loop to iterate length times, supplementing random numbers [from, to]
  for (var i = 0; i < length; i++) {
    resultList[i] = randomGen.nextInt(to - from + 1) +
        from; // from method - [0, to - from] --> [from, to]
  }

  return resultList;
}
