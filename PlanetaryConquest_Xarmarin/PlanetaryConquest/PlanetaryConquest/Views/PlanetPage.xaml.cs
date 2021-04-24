using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace PlanetaryConquest.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class PlanetPage : ContentPage
    {
        public PlanetPage()
        {
            InitializeComponent();

            // tailors planet list view to
            this.PlanetsList.ItemsSource = App.Shared.Planets;
        }

        // renders event handler to append planet to observables collection
        public void AddPlanet(System.Object obj, System.EventArgs args)
        {

            double distanceEntry;

            // input check (NameEntry cannot be null or empty, DistanceEntry cannot be null or empty and must be positive)
            if (String.IsNullOrEmpty(this.PlanetNameEntry.Text) || String.IsNullOrEmpty(this.PlanetDistanceEntry.Text))
            {
                this.DisplayErrorAlertForInvalidInput();
                return;
            }

            // parses distance string to double (will never fail)
            distanceEntry = Double.Parse(this.PlanetDistanceEntry.Text);

            if (distanceEntry <= 0)
            {
                this.DisplayErrorAlertForInvalidInput();
                this.PlanetDistanceEntry.Text = "";
                return;
            }

            // appends entry fields to solar system as a planet - if addition fails, raise prompt  of invalid state
            if (!App.Shared.AddPlanet(this.PlanetNameEntry.Text, distanceEntry))
                this.DisplayAlert("Oops!", "Something went wrong adding your planet, please check that the planet name is unique", "OK");

                // clears inputs
                this.PlanetDistanceEntry.Text = "";
                this.PlanetNameEntry.Text = "";

            
        }

            /// <summary>
            /// Displays alert prompt apprising user that 1 or more inputs are invalid.
            /// </summary>
            private void DisplayErrorAlertForInvalidInput()
            {
                this.DisplayAlert("Invalid Input", "Please make sure no inputs are empty and distance is greater than 0!", "OK");
            }

    }
}