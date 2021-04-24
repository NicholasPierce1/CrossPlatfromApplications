using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.Linq;

namespace PlanetaryConquest.Models
{
    /// <summary>
    /// Holds numerous Planets in the same solar system.
    /// Members: Observable list of all planets
    /// Methods: For adding and sorting planets- as well as finding distances between any two planets.
    /// </summary>
    internal sealed class SolarSystem
    {


        // creates local, constant for time travel
        private static readonly int TIME_TRAVEL_CONSTANT = 8;

        // defines static, singleton
        internal static SolarSystem Shared { get; private set; } = new SolarSystem();

        // internal constant for erroneous invocations of Shared's methods (ie: planet name does not exist)
        internal static int noSuchPlanet { get; private set; } = -1;

        // enumerates instance memebers

        // holds all planets, in percise order of ascending distances, that are involved in this's solar system
        public ObservableCollection<Planet> Planets { get; private set; } = new ObservableCollection<Planet>();

        // local method to render the defualt, initial planets
        private void InitializePlanets()
        {
            // appends intial planets (Mercury, Venus, Earth, Mars)
            // NOTE: TEMPORARILY OUT OF ORDER TO TEST SORT
            this.Planets.Add(new Planet("Mars", 1.524));
            this.Planets.Add(new Planet("Mercury", .39));
            this.Planets.Add(new Planet("Venus", .72));
            this.Planets.Add(new Planet("Earth", 1));
            
        }

        // default, no arg constructor that initializes that planets
        private SolarSystem() { this.InitializePlanets(); this.ResortList(); }

        /// <summary>
        /// Finds planet via its name- ignoring case.
        /// </summary>
        /// <param name="planetName">The name of the planet to compare to other planets in solar system- ignoring case.</param>
        /// <returns>A tuple where the bool 'PlanetFound' denotes if a planet has been found and the Planet 'Planet'.
        /// Note: 'Planet' will be null if no match is found.
        /// </returns>
        /// <exception cref="ArgumentException">If planetName is null or empty</exception>
        private (bool PlanetFound, Planet Planet) FindPlanetByName(String planetName) {

            if (String.IsNullOrEmpty(planetName)) throw new ArgumentException($"{nameof(planetName)} cannot be null or empty");

            // iterates over all planets, if one is found, return it, else return false results
            foreach (Planet planet in this.Planets)
            {
                // checks equality, ignoring case of the comparison-strings
                if (planet.Name.Equals(planetName, StringComparison.OrdinalIgnoreCase))
                    return (true, planet);
            }

            return (false, null);
        }

        /// <summary>
        /// Resorts the Observable Collection while maintaining the current object reference to where notifications still propagate.
        /// </summary>
        private void ResortList() {

            // acquires an IEnumerable from the observable collection that's sorted on the Comparer<Planet> predicate
            IList<Planet> sortedPlanets = new List<Planet>(this.Planets.OrderBy<Planet, Planet>(delegate (Planet source) { return source; }).ThenBy<Planet,String>(
                delegate(Planet source) { return source.Name; }));

            // removes all planets in current, unsorted list
            this.Planets.Clear();

            // adds all, now sorted planets, to the observable collection
            foreach (Planet planet in sortedPlanets)
                this.Planets.Add(planet);
        }

        /// <summary>
        /// Finds the corresponding planet per name, if any, and returns its distance.
        /// </summary>
        /// <param name="planetName">Name of planet to search. Cannot be empty or null</param>
        /// <returns>The positive distance of the planet OR -1 (noSuchPlanet) if not found.</returns>
        /// <exception cref="ArgumentException">If planetName is null or empty</exception>
        internal double FindDistanceToPlanet(String planetName)
        {

            // checks attribute planetName is valid -- not null or empty
            if (String.IsNullOrEmpty(planetName)) throw new ArgumentException($"{nameof(planetName)} cannot be null or empty");

            // finds name of planet that matches
            var planetSearchResult = this.FindPlanetByName(planetName);

            if (!planetSearchResult.PlanetFound) return SolarSystem.noSuchPlanet;

            // planet found, return its distance (Never null)
            return planetSearchResult.Planet.Distance;
        }

        /// <summary>
        /// Calculates the time required to travel between the two planets.
        /// </summary>
        /// <param name="planetOneName">Name of planet one - order does not matter. Cannot be null or empty</param>
        /// <param name="planetTwoName">Name of planet two - order does not matter. Cannot be null or empty</param>
        /// <returns>The distance between the two planets or -1 (noSuchPlanet)</returns>
        /// <exception cref="ArgumentException">If planetName is null or empty</exception>
        internal double TimeToTravelBetween(String planetOneName, String planetTwoName)
        {

            // validates inputs from both params (not null or empty)
            if (String.IsNullOrEmpty(planetOneName) || String.IsNullOrEmpty(planetTwoName))
                throw new ArgumentException($"{nameof(planetOneName)} and/or {nameof(planetTwoName)} is null or empty.");

            // searches for both planets- if either is not found, return noSuchPlanet
            var planetOneSearchResult = this.FindPlanetByName(planetOneName);
            var planetTwoSearchResult = this.FindPlanetByName(planetTwoName);

            if (!planetOneSearchResult.PlanetFound || !planetTwoSearchResult.PlanetFound) return SolarSystem.noSuchPlanet;

            // returns distance between two planets to the product of the time travel constant
            return Math.Abs(planetOneSearchResult.Planet.Distance - planetTwoSearchResult.Planet.Distance) * SolarSystem.TIME_TRAVEL_CONSTANT;

        }

        /// <summary>
        /// Creates and adds a planet to the observable collection. Observable collection will then resort itself.
        /// </summary>
        /// <param name="planetName">Unique name of planet. Cannot be null or empty</param>
        /// <param name="distance">Distance from sun. Cannot be less than 0</param>
        /// <returns>A bool indicating if the inputs were valid and the planet was added.</returns>
        internal bool AddPlanet(String planetName, Double distance)
        {
            // validates inputs (name cannot be null or empty) (distance cannot be <= 0)
            if (String.IsNullOrEmpty(planetName) || distance <= 0) return false;

            // checks if planet is unique - if not, then return false
            if (!this.PlanetNameIsUnique(planetName)) return false;

            // creates planet and adds it to list (capitalizing the planet's name)
            this.Planets.Add(new Planet(Char.ToUpper(planetName[0]) + planetName.Substring(1), distance));

            // sorts planet list
            this.ResortList();

            return true;
        }

        /// <summary>
        /// Denotes if planet name is unique
        /// </summary>
        /// <param name="planetName">Name of planet. Cannot be null or empty.</param>
        /// <returns>A bool indicating if the planet is unique or not</returns>
        /// <exception cref="ArgumentException">If planetName is null or empty</exception>
        private bool PlanetNameIsUnique(String planetName)
        {
            // checks attribute planetName is valid -- not null or empty
            if (String.IsNullOrEmpty(planetName)) throw new ArgumentException($"{nameof(planetName)} cannot be null or empty");

            return !this.FindPlanetByName(planetName).PlanetFound;
        }


    }


}
