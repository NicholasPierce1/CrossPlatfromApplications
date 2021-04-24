import React, {useState} from 'react';
import { StyleSheet, Text, View, FlatList, TextInput, Button, Alert } from 'react-native';
import SolarSystem, {NO_SUCH_PLANET} from "./solar-system.js";
import { NavigationContainer } from '@react-navigation/native';
import MaterialCommunityIcons from "react-native-vector-icons/MaterialCommunityIcons";
import {createBottomTabNavigator} from "@react-navigation/bottom-tabs";
import Planet from "./planet";

const solarSystem = new SolarSystem();

export function PlanetsScreen() {

  // creates state object comprised of two string (planetName & planetDistance) + the list from solar system
  const [planetScreenState, updatePlanetScreenState] = useState({
    planetName: "",
    planetDistance: 0,
    planets: solarSystem.planets
  });

  return (
    <View style={styles.container}>
      
      {
        // creates header (centered, big text,)
        
      }
      <View style={[styles.headerStyles, styles.crossAxisContainer]}>
        <Text style={{fontSize: 40, flex: 1, textAlign: "center"}}>Planets!</Text>
      </View>

      {
        // creates FlatList displaying planets (start, column view)

        // -- data: initial list values

        // -- extraData: set to state-hook var to append dynamic behaviors
        
      }
      <View style={[styles.planetListStyles, styles.crossAxisContainer]}>
        <FlatList
          style={{flex: 1, backgroundColor: "white"}}
          extraData={planetScreenState.planets}
          data={planetScreenState.planets}
          renderItem={({item, index}) => {
            console.log(item.name);
            return (
            <View style={{flexDirection: "column", flex: 1}}>
              <Text style={{fontSize: 25, flex : 3, fontWeight: "700"}}>{item.name}</Text>
              <Text style={{fontSize: 15, flex : 1}}>{item.distance}</Text>
            </View>
            );
        
          }
          
        }
        />
      </View>

      {
        // creates input row for rendering new planets (flex-start, normal text,)
        
      }
      <View style={[styles.newPlanetInputStyles, styles.crossAxisContainer]}>
        <TextInput 
         style={{flex: 1, fontSize: 20, paddingLeft: 5, color: "black"}}
         placeholder= "Enter planet name"
         keyboardType="default" 
         numberOfLines={1}
         value={planetScreenState.planetName}
         onChangeText={function(planetName){         

          // enjoins the update of current state values w/ merging of old state (required)
          updatePlanetScreenState( (oldState)=>( { ...oldState, 
            planetName: planetName
          }));

          }}
          onEndEditing={function({e}){

          }}
          />

        <TextInput 
         style={{flex: 1, fontSize: 20, paddingLeft: 5}}
         placeholder= "Enter planet distance"
         keyboardType="numeric" 
         numberOfLines={1}
         value={parseFloat(planetScreenState.planetDistance) ? planetScreenState.planetDistance : `${planetScreenState.planetDistance}`}
         onChangeText={function(planetDistance){

        // enjoins the update of current state values w/ merging of old state (required)
        updatePlanetScreenState( (oldState)=>( { ...oldState, 
          planetDistance: planetDistance
        }));}
        
        }

        onEndEditing={function({e}){ 

        }
        }


          />

      </View>

      {
        // creates padding for input and submit button (centered, big text,)
        
      }
      <View style={[styles.newPlanetInputPaddingStyles, styles.crossAxisContainer]}>
        
      </View>

      {
        // creates submit button for rendering a new planet (centered, big text,)
        
      }
      <View style={[styles.addNewPlanetButtonStyles, styles.crossAxisContainer]}>
        <Button title="Add New Planet" onPress={function(){ 

          // trys to convert distance to float
          if(!parseFloat(planetScreenState.planetDistance)){

            displayAlert("Error", "Planet's distance must be a valid number");
  
            // enjoins the update of current state values w/ merging of old state (required)
            updatePlanetScreenState( (oldState)=>( { ...oldState, 
              planetDistance: ""
            }));

            return;

          }

          if( parseFloat(planetScreenState.planetDistance) <= 0){
            displayAlert("Error", "Plantet's distance cannot be less than 1");

            // enjoins the update of current state values w/ merging of old state (required)
            updatePlanetScreenState( (oldState)=>( { ...oldState, 
              planetDistance: ""
            }));

            return;
          }

          // validate (not empty)
          if(planetScreenState.planetName === "" || parseFloat(planetScreenState.planetDistance) <= 0){
            displayAlert("Error", "Planet name cannot be empty");

            return;
          }

          // uses current hook state and renders a new planet - passing it into the solar system
          // if not true -- ie: planet equals another, raise error alert
          if(!(solarSystem.addPlanet(planetScreenState.planetName, parseFloat(planetScreenState.planetDistance)))){
            displayAlert("Error In Creating Planet", "Both the planet's name and distance must be unique");
            return;
          }

          // update hook state (clears input values)
          updatePlanetScreenState( (oldState)=>( { ...oldState, 
            planets: solarSystem.planets,
            planetDistance: "",
            planetName: ""
          })); 

        }}/>
      </View>

    </View>
  );
}

export function TimeTravelScreen() {

  // create hook state object that's comprised of two vars (planetName1, planetName2)
  const [timeTravelScreenState, updateTimeTravelScreenState] = useState({
    planetName1: "",
    planetName2: ""
  });

  return (
    <View style={styles.container}>

      
      {
        // creates row of input fields (flex-start, normal text,)
        
      }
      <View style={[styles.crossAxisContainer, {flex: 1, justifyContent: "flex-start", alignItems: "center", marginBottom: 20}]}>
        <Text style={{fontSize: 40, flex: 1, textAlign: "center"}}>Time Travel</Text>
      </View>
      
      {
        // creates header (centered, big text,)
        
      }
      <View style={[styles.crossAxisContainer, {flex: 1, marginBottom: 20}]}>
        <TextInput 
         style={{flex: 1, fontSize: 20, paddingLeft: 5, color: "black", marginLeft: 10}}
         placeholder= "planet one"
         keyboardType="default" 
         numberOfLines={1}
         value={timeTravelScreenState.planetName1}
         onChangeText={function(planetName){         

          // enjoins the update of current state values w/ merging of old state (required)
          updateTimeTravelScreenState( (oldState)=>( { ...oldState, 
            planetName1: planetName
          }));

          }}
          />

        <TextInput 
         style={{flex: 1, fontSize: 20, paddingLeft: 5, color: "black"}}
         placeholder= "planet two"
         keyboardType="default" 
         numberOfLines={1}
         value={timeTravelScreenState.planetName2}
         onChangeText={function(planetName){         

          // enjoins the update of current state values w/ merging of old state (required)
          updateTimeTravelScreenState( (oldState)=>( { ...oldState, 
            planetName2: planetName
          }));

          }}
          />
      </View>

      {
        // creates submit button (centered, normal text,)
        
      }
      <View style={[styles.crossAxisContainer, {flex: 1, justifyContent: "flex-start", alignItems: "center"}]}>
        <Button title="Calculate Distance" onPress={function(){ 

          // validate (not empty)
          if(timeTravelScreenState.planetName1 === "" || timeTravelScreenState.planetName1 === ""){
            displayAlert("Error", "Planet one and/or two name cannot be empty");
            return;
          }

          // holds value from distance calculation
          const distance = solarSystem.timeToTravelBetween(timeTravelScreenState.planetName1, timeTravelScreenState.planetName2)

          // uses current hook state and renders a new planet - passing it into the solar system
          // if not true -- ie: planet equals another, raise error alert
          if(distance === NO_SUCH_PLANET){
            displayAlert("No such planet", `Either ${timeTravelScreenState.planetName1} or ${timeTravelScreenState.planetName2} or possible both don't exist`);
            return;
          }

          // displays distance
          displayAlert("Alert", `Time to travel between ${timeTravelScreenState.planetName1} and ${timeTravelScreenState.planetName2} is ${distance}`);

          // update hook state (clears input values)
          updateTimeTravelScreenState( (oldState)=>( { ...oldState, 
            planetName1: "",
            planetName2: ""
          })); 

          }}/>
      </View>

      {
        // creates space / padding on bottom
      }
      <View style={{flex: 5}}>
      </View>
 
    </View>
  );
}

const Tab = createBottomTabNavigator();
export default function App() {
 return (
 <NavigationContainer>
  <Tab.Navigator tabBarOptions={{activeTintColor:'red', labelPosition:'beside-icon'}}>
    <Tab.Screen name="PlanetsScreen" component={PlanetsScreen}
      options={{
      tabBarLabel: 'Planets',
      }} />
    <Tab.Screen name="TimeTravelScreen" component={TimeTravelScreen}
      options={{
      tabBarLabel: 'Time Travel',
      }} />
  </Tab.Navigator>
 </NavigationContainer>
 );
} 

// helper function to display error of validation || entering data actions
function displayAlert(title, message){
  Alert.alert(title,message);
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: "column",
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'flex-start',
    paddingTop: 50
  },
  crossAxisContainer: {
    flexDirection: "row"
  },
  rowContainerStyles: {
    flexDirection: "row"
  },
  headerStyles: {
    flex: 4,
  },
  planetListStyles: {
    flex: 30
  },
  newPlanetInputStyles: {
    flex: 5,
    justifyContent: "flex-start",
    alignItems: "center"
  },
  newPlanetInputPaddingStyles: {
    flex: 3
  },
  addNewPlanetButtonStyles: {
    flex: 5,
    justifyContent: "center",
    alignItems: "flex-start"
  }
});
