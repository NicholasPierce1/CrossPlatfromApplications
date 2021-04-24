import { NativeModules } from "react-native";

// creates definition of a planet
export default function Planet(name, distance){

    // enumerates instance members
    this.name = name;
    this.distance = distance;

    // denotes key extractor value for unique identification (name is unique)
    this.id = name;
}

// appends function member to denote if two planets are equal (equal)
Planet.prototype.equals = function(planet){

    // if planet is not same type - throw error
    if(!(planet instanceof Planet))
        throw `Planet is of type ${typeof(planet)} but expected: Planet`;

    // returns true if the name or distance are equal
    return this.name == planet.name || this.distance == planet.distance;
};

// appends function members to implement comparability (comparable)
Planet.prototype.compareTo = function(planet){

    // type check on planet
    if(!(planet instanceof Planet))
        throw `Planet is of type ${typeof(planet)} but expected: Planet`;
    
    // returns the comparison predicate (distance)
    return this.distance - planet.distance;
};
