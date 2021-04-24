using System;
using System.Collections.Generic;
using System.Text;

namespace PlanetaryConquest.Models
{
    /// <summary>
    /// Retains definition for a single planet
    /// Members: Name and Distance
    /// Methods: No unique functionality
    /// Implements: IComparable for default sorting predicate
    /// </summary>
    internal sealed class Planet: IComparable
    {

        // enumerates instance memebers
        public String Name { get; internal set; }

        public Double Distance { get; internal set; }

        // default constructor to assign values to Name and Distance
        internal Planet(String name, Double distance)
        {
            this.Name = name;
            this.Distance = distance;
        }

        /// <summary>
        /// Sorts Planets according to the instance's respective Distance.
        /// If the passed planet, upcasted into an object, is null then "1" is  return.
        /// If the passed object cannot be downcasted into a Planet then a CastException is thrown.
        /// </summary>
        /// <param name="obj">Upcasted Planet to compare to calling instance</param>
        /// <returns>See IComparable.CompareTo implementation for details.</returns>
        /// <exception cref="InvalidCastException">If the upcasted object is NOT a Planet</exception>
        int IComparable.CompareTo(object obj)
        {

            // if passed object is null then 1 is returned
            if (obj is null) return 1;

            // conditional cast to Planet - throw exception if cast fails
            Planet planetToCompare = obj as Planet;
            if (planetToCompare is null) throw new InvalidCastException($"{nameof(obj)} is not a {nameof(Planet)}.");

            // returns the comparison of the distance
            return this.Distance.CompareTo(planetToCompare.Distance);
        }

        // overrides to string implementation
        public override String ToString() { return $"{this.Name}, {this.Distance}"; }
    }
}
