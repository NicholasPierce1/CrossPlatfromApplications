// 0
// denotes if the target number passed in is between the bounds
function between(number, lower, upper, inclusvie=false){

    // calculates the shift that'll be applied upon the bounds
    const shift = inclusvie ? 0 : 1;

    // returns if the number is between the (bounds - shift)
    return number >= lower + shift && number <= upper - shift;
}

// prints out outputs of between operation
console.log(`between output (expected true): ${between(15,10, 20, true)}`); // return true, since 15 is between 10 and 20, inclusive
console.log(`between output (expected false): ${between(5,10, 20, true)}`); // return false, since 5 is not between 10 and 20, inclusive
console.log(`between output (expected true): ${between(15,10, 20)}`);  // return true since 15 is between 10 and 20,
console.log(`between output (expected true): ${between(15,10, 15, true)}`);  // return true since 15 is between 10 and 15, inclusive
console.log(`between output (expected false): ${between(15,10, 15, false)}\n\n`);  // return false since 15 is not between 10 and 15 exclusive

// 1
// determines if the plane is safe to land on the runway
function safeToLand(windSpeed, windDirection, runaway, hasIce){

    // if windspeed less than 5 - always safe
    if(windSpeed < 5) return true;
    // if if windspeed { [5, 10] AND no ice - safe
    else if(windSpeed <= 10 && !hasIce) return true;
    // if windDirection - runawayHeading < 30 (where runawayHeading = runaway * 10) - sage
    else if( (windDirection - (runaway * 10)) < 30 && !hasIce) return true;
    // default: not safe to land
    else return false;
}

// prints outputs for the safeToLand function
console.log(`safeToLand output (expected true): ${safeToLand(3, 340, 18, false)}`) // true - windSpeed is < 5
console.log(`safeToLand output (expected true): ${safeToLand(8, 340, 18, false)}`)  // true - windSpeed between 5-10, no ice
console.log(`safeToLand output (expected false): ${safeToLand(8, 340, 18, true)}`)  // false - windSpeed between 5-10, but ice
console.log(`safeToLand output (expected true): ${safeToLand(12, 340, 32, false)}`)  // true - windSpeed exceeds 10, but no ice and difference between windDirection (340) and runway heading (320) < 30
console.log(`safeToLand output (expected false): ${safeToLand(12, 340, 30, false)}\n\n`)  // false windSpeed exceeds 10, no ice but difference between windDirection (340) and runway heading (300) ≥ 30 

// 2 a
// creates a constructor function for Animal comprised of (name, weight, and speak method)
function Animal(name, phrase, weight = 0){

    // type checks on inputs
    if(typeof(name) !== "string" || typeof(weight) !== "number" || typeof(phrase) !== "string")
        throw Error `name should be string, weight should be number, and phrase should be string or unset`;

    // enumerates instance members
    this.name = name;
    this.phrase = phrase;
    this.weight = weight;

}

// assigns phrase function to prototype
Animal.prototype.speak = function(){console.log(`I am an animal and I would like to say ${this.phrase}`);};

// 2 b
// re-cretes animal class as an ES6 class
class Animal6{

    // defines constructor
    constructor(name, phrase, weight = 0){
    // type checks on inputs
    if(typeof(name) !== "string" || typeof(weight) !== "number" || typeof(phrase) !== "string")
        throw Error `name should be string, weight should be number or unset, and phrase should be string`;

    // enumerates instance members
    this.name = name;
    this.phrase = phrase;
    this.weight = weight;
    }

    // creates speak function
    speak(){console.log(`I am an animal and I would like to say ${this.phrase}`);}
}



// 2C
// creates Turtle class that extends Animal with unique state (x & y)
function Turtle(name, phrase, weight = 0){

    // invokes super, passing this into it for inheritance
    Animal.call(this, name, phrase, weight);

    // enumerates instance members
    this.x = 0;
    this.y = 0;

}

// tailors Animal prototype to mine and re-assigns constructor to mine first
Turtle.prototype = Object.create(Animal.prototype);
Turtle.prototype.constructor = Turtle;

// tailors move method to transmute current coordinates
Turtle.prototype.move = function(deltaX, deltaY){
    this.x += deltaX;
    this.y += deltaY;
};

// overrides speak method
Turtle.prototype.speak = function(){console.log(`I'm am a turtle, and I would like to say ${this.phrase}`);};



// 2D
// re-creates turtle w/ es6 class
class Turtle6 extends Animal6{

    // create constructor function
    constructor(name, phrase, weight = 0){

        // invokes super
        super(name, phrase, weight);

        // enumerates instance members
        this.x = 0;
        this.y = 0;
    }

    // tailors move method to transmute current coordinates
    move(deltaX, deltaY){
        this.x += deltaX;
        this.y += deltaY;
    }

    // overrides speak method
    speak(){
        console.log(`I'm am a turtle, and I would like to say ${this.phrase}`);
    }

}



// 2E
// creates two turtles seymour and papert respectively
const seymour = new Turtle("seymour", "*turtle noise*");
const papert = new Turtle6("papert", "*turtle noises*");

// 2F

// seymour speaks
seymour.speak();

// papert moves 5 in x  and -3 in y direction
papert.move(5, -3);