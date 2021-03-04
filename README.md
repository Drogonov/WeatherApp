# WeatherApp
> test project builded in Clean Swift Architecture

## Table of contents
* [General info](#general-info)
* [Screenshots](#screenshots)
* [Technologies](#technologies)
* [Setup](#setup)
* [Status](#status)
* [Contact](#contact)

## General info

This app can fetch weather data in city which User choose by writing cityName in textfield at CityAddScreen
Also user can change tempType from celsius to fahrenheit, and delete city from CitySettingsScreen

Yep and if you pull tableView down city info will updates)

- WeatherViewController
* First loads saved weather, then loads new weather through API call if there are nothing to show it shows label "ДОБАВЬТЕ ГОРОД"
* After data loaded you can swipe cities by collectionView or pageView
* Press button to show CitySettingsScreen

- CitySettingsViewController
* Loads saved weather in tableView
* You can delete city by swiping left (when you do it info through routing will goes to WeatherViewController)
* In FooterView you can change tempType (when you do it info through routing will goes to WeatherViewController)
* By pressing plus button in FooterView you can go to CityAddViewController
* When you pull table view down works API call which update saved info

- CityAddViewController
* You can add new city (Info goes to CityAddViewController through routing)
* If all is ok you can see .success alert
* If city name is wrong or some other mistake occur user get .error alert

## Screenshots
![Home Screen before data adding](/Screenshots/HomeScreen_empty.png)
![Home Screen after data was added](/Screenshots/HomeScreenWithData.png)
![Settings Screen to delete cities and change weather settings](/Screenshots/SettingsScreen.png)
![City Adding screen](/Screenshots/CityAddScreen.png)
![User gets alert when city adding](/Screenshots/CityAdded.png)
![User gets alert if cityName was wrong or data cant be fetched](https://github.com/Drogonov/WeatherApp/blob/main/Screenshots/CityAddScreen.png)


## Technologies
* Clean Swift as Architecture pattern
* OpenWeatherMap API for get the weather data
* UserDefaults for data storage

## Setup
For the project i desided to avoid using cocoa pods so you need only Xcode to build it

## Status
Project is: _finished_ It was test for my skills and playground to understand in General how Clean Swift works for me.

## Contact
Created by [@drogonov](https://career.habr.com/drogonov) - feel free to contact me!
