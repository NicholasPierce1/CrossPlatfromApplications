void main(){
  invokeAllFunctionsWithLabels();
}

// main static method to call all created methods as perscribed by the assignment (fun with dart)
invokeAllFunctionsWithLabels(){

  // Q1 V1
  print("Question 1 Version 1");
  print("Case 1 ${travelling(50, 60, false)}");
  print("Case 2: ${travelling(50, 45, false)}");
  print("Case 3: ${travelling(50, 35, false)}");
  print("Case 4: ${travelling(50, 35, true)}\n");

  // Q1 V2
  print("Question 1 Version 2");
  print("Case 1 ${travelling2(at:50, speedLimit:60, yourBday: false)}");
  print("Case 2: ${travelling2(at:50, speedLimit:45, yourBday: false)}");
  print("Case 3: ${travelling2(at:50, speedLimit:35, yourBday: false)}");
  print("Case 4: ${travelling2(at:50, speedLimit:35, yourBday: true)}\n");

  // Q1 V3
  print("Question 1 Version 3");
  print("Case 1 ${travelling3(50, 60, false)}");
  print("Case 2: ${travelling3(50, 45)}");
  print("Case 3: ${travelling3(50, 35)}");
  print("Case 4: ${travelling3(50, 35, true)}\n");

  // Q2
  print("Question 2");
  print("Case 1: ${lucky13([5, 10, 15])}");
  print("Case 2: ${lucky13([])}");
  print("Case 3: ${lucky13([1, 10, 15])}");
  print("Case 4: ${lucky13([1, 3, 10, 15])}\n");

  // Q3
  print("Question 3");
  print("Case 1: ${numDaysIn(month: "September", year: 2018)}");
  print("Case 2: ${numDaysIn(month: "January", year: 2016)}");
  print("Case 3: ${numDaysIn(month: "February", year: 2016)}");
  print("Case 4: ${numDaysIn(month: "February", year: 2015)}\n");

}

// Q1, V1 speed calculator with non-named/positional parameters.
double travelling(final int at, final int speedLimit, final bool yourBday){

  // local member to hold speed infraction
  final int speedOver = at - speedLimit;

  // nested if-else block for bday- then ticket calculator
  if(yourBday){

    // [6-15] ~ 100
    if(speedOver >= 6 && speedOver <= 15)
      return(100);
    // [16-25] ~ 200
    else if(speedOver >= 16 && speedOver <= 25)
      return(200);
    // [26+] ~ 500
    else if(speedOver >= 26)
      return(500);
    // no offense
    else
      return(0);

  }
  else{  // not your bday

    // [1-10] ~ 100
    if(speedOver >= 1 && speedOver <= 10)
      return(100);
    // [11-20] ~ 200
    else if(speedOver >= 11 && speedOver <= 20)
      return(200);
    // [21+] ~ 500
    else if(speedOver >= 21)
      return(500);
    // no offense
    else
      return(0);

  }
}

// Q1, V2 speed calculator with named parameters.
double travelling2({final int at, final int speedLimit, final bool yourBday}){

  // local member to hold speed infraction
  final int speedOver = at - speedLimit;

  // nested if-else block for bday- then ticket calculator
  if(yourBday){

    // [6-15] ~ 100
    if(speedOver >= 6 && speedOver <= 15)
      return(100);
    // [16-25] ~ 200
    else if(speedOver >= 16 && speedOver <= 25)
      return(200);
    // [26+] ~ 500
    else if(speedOver >= 26)
      return(500);
    // no offense
    else
      return(0);

  }
  else{  // not your bday

    // [1-10] ~ 100
    if(speedOver >= 1 && speedOver <= 10)
      return(100);
    // [11-20] ~ 200
    else if(speedOver >= 11 && speedOver <= 20)
      return(200);
    // [21+] ~ 500
    else if(speedOver >= 21)
      return(500);
    // no offense
    else
      return(0);

  }
}

// Q1, V3 speed calculator with positional parameters.
double travelling3([final int at, final int speedLimit, final bool yourBday = false]){

  // local member to hold speed infraction
  final int speedOver = at - speedLimit;

  // nested if-else block for bday- then ticket calculator
  if(yourBday){

    // [6-15] ~ 100
    if(speedOver >= 6 && speedOver <= 15)
      return(100);
    // [16-25] ~ 200
    else if(speedOver >= 16 && speedOver <= 25)
      return(200);
    // [26+] ~ 500
    else if(speedOver >= 26)
      return(500);
    // no offense
    else
      return(0);

  }
  else{  // not your bday

    // [1-10] ~ 100
    if(speedOver >= 1 && speedOver <= 10)
      return(100);
    // [11-20] ~ 200
    else if(speedOver >= 11 && speedOver <= 20)
      return(200);
    // [21+] ~ 500
    else if(speedOver >= 21)
      return(500);
    // no offense
    else
      return(0);

  }
}

// Q2 returns true if a '1' or a '3'
bool lucky13(final List<int> numbers){
  for(int i = 0; i < numbers.length; i++){

    // local reference to number extracted from list
    final int num = numbers[i];

    // 1 or 3, return false
    if(num == 1 || num == 3)
      return false;
  }

  // out of loop, no 1 or 3 recovered
  return true;
}

// Q3 returns the days in the certain month of the certain year
int numDaysIn({final String month, final int year}){

  // employs a switch
  switch(month){
    case "January":
      return 31;
      break;
    case "February":
      // if not divisible by 4 -- common year
      if(!(year % 4 == 0))
        return 28;
      // if not divisible by 100 -- leap year
      else if(!(year % 100 == 0))
        return 29;
      // if not divisible by 400 -- common year
      else if(!(year % 400 == 0))
        return 28;
      // else its a leap year
      else
        return 29;
      break;
    case "March":
      return 31;
      break;
    case "April":
      return 30;
      break;
    case "May":
      return 31;
      break;
    case "June":
      return 30;
      break;
    case "July":
      return 31;
      break;
    case "August":
      return 31;
      break;
    case "September":
      return 30;
      break;
    case "October":
      return 31;
      break;
    case "November":
      return 30;
      break;
    default:
      return 31;
      break;
  }
}
