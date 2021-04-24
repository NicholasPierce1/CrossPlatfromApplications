// imports planets
import Planet from "./planet.js";

// indicates constant value for no such planet
export const NO_SUCH_PLANET = -1;

// indicates constance value for speed of light travel
const SPEED_OF_LIGHT_MULTIPLIER = 8;

// defines solar system that's comprised of planets
export default function SolarSystem(){

    // enumerates instance members

    // holds planets (with default values provided)
    this.planets = [new Planet("Mercury", .39), new Planet("Venus", .72), new Planet("Earth", 1), new Planet("Mars", 1.524)];
}

// appends two method handlers to the definition of Solar System -- outside class per optimization

// calculates distance between two planets
SolarSystem.prototype.calculateDistance = function(planetName){

    // type check of planetName
    if(!(typeof(planetName) === "string"))
        throw `Expected string, but found ${typeof(planetName)}`;

    // finds planet
    const planet = this.findPlanetByName(planetName);

    // returns the planet's distance or no such planet
    return planet ? planet.distance : NO_SUCH_PLANET;
    
};

// appends function memeber to calculate distance between two planet names - returns distance or no such planet
SolarSystem.prototype.timeToTravelBetween = function(planetName1, planetName2){

    // type check on planet names
    if(!(typeof(planetName1) === "string" && typeof(planetName1) === "string"))
        throw error `Expected planetName1 and planetName2 to be of string but found: ${typeof(planetName1)} and ${typeof(planetName2)}`;
    
    // finds both planets by name
    const planet1 = this.findPlanetByName(planetName1);
    const planet2 = this.findPlanetByName(planetName2);

    // returns distance of both planets or no such planet
    return (planet1 && planet2) ? (this.calculateDistance(planet2.name) - this.calculateDistance(planet1.name)) * SPEED_OF_LIGHT_MULTIPLIER : NO_SUCH_PLANET;
};

// helper method to add a planet
SolarSystem.prototype.addPlanet = function(name, distance){

    // type check of arguments
    if(!(typeof(name) === "string" && typeof(distance) === "number"))
        throw error `Expected name to be string and distance to be number but found: name(${typeof(name)}) and distance(${distance})`;

    // creates new planet
    const planetToAdd = new Planet(name, distance);

    // if the planet does not exist, add it to array, re-sort, and return true
    if(this.validatePlanetIsNotUniqueSync(planetToAdd))
        return false;
    
    this.planets.push(planetToAdd);
    this.sortPlanets();

    return true;
}

// helper method to validate a planet
SolarSystem.prototype.validatePlanetIsNotUniqueSync = function(planet){

    // type check on planet
    if(!(planet instanceof Planet))
        throw error `Expected argument to be type of Planet`;
    
    // attempts to find a planet where they are equal (using Planet's equitable interface**) (true- planet found, false otherwise)
    return this.planets.find(function(otherPlanet){return otherPlanet.equals(planet);}, this);
};

// helper method to find planet in array per name
SolarSystem.prototype.findPlanetByName = function(name){

    // type check of planetName
    if(!(typeof(name) === "string"))
        throw `Expected string, but found ${typeof(name)}`;

    // returns the planet with matching name - undefined if otherwise
    return this.planets.find(function(planet){return planet.name === name;}, this);
    
};

// helper method to sort the planets array using Planet's comparable implementation
SolarSystem.prototype.sortPlanets = function(){
    this.planets.sort(function(planet1, planet2){return planet1.compareTo(planet2);});
};



export function trash(){}