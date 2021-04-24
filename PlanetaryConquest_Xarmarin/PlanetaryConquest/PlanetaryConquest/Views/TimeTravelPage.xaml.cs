using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PlanetaryConquest.Models;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace PlanetaryConquest.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class TimeTravelPage : ContentPage
    {
        public TimeTravelPage()
        {
            InitializeComponent();
        }

        // appends event to conditionally extract and pass user text to solar system to prompt an alert of the distance
        public void CalculateDistance(System.Object obj, System.EventArgs args)
        {

            // validates that both inputs are not null or empty ( display alert and clear inputs )
            if(String.IsNullOrEmpty(this.PlanetOneNameEntry.Text) || String.IsNullOrEmpty(this.PlanetTwoNameEntry.Text))
            {
                this.DisplayAlertOfInvalidInput(false);
                return;
            }

            // passes planet names into solar system to calculate distance
            double distanceResults = App.Shared.TimeToTravelBetween(this.PlanetOneNameEntry.Text, this.PlanetTwoNameEntry.Text);

            // if result is 'noSuchPlanet' then display error to user
            if (distanceResults.Equals(SolarSystem.noSuchPlanet))
                this.DisplayAlertOfInvalidInput(true);
            else
                this.DisplayAlert($"Time to travel from {this.PlanetOneNameEntry.Text} to {this.PlanetTwoNameEntry.Text}", $"{distanceResults} minutes.", "OK");


            // clears inputs
            this.PlanetOneNameEntry.Text = "";
            this.PlanetTwoNameEntry.Text = "";

        }

        private void DisplayAlertOfInvalidInput(bool inputsNotNullOrEmpty)
        {
            if(inputsNotNullOrEmpty)
                this.DisplayAlert("No such Planet", $"Either {this.PlanetOneNameEntry.Text} or {this.PlanetTwoNameEntry.Text} or possibly both do not exist", "OK");
            else
                this.DisplayAlert("Empty Inputs", "Either one or more inputs are empty. Please Enter planet names.", "OK");

        }
    }
}