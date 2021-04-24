using System;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using PlanetaryConquest.Views;
using PlanetaryConquest.Models;

namespace PlanetaryConquest
{
    public partial class App : Application
    {

        // creates constant, class memeber to solar system singelton
        internal static SolarSystem Shared { get; private set; } = SolarSystem.Shared;

        public App()
        {
            InitializeComponent();

            MainPage = new MainPage();
        }

        protected override void OnStart()
        {
        }

        protected override void OnSleep()
        {
        }

        protected override void OnResume()
        {
        }
    }
}
