//
//  DataFetcherService.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//

import Foundation

class DataService {
    
    struct UserDefaultKeys {
        static let savedWeather = "savedWeather"
    }
    
    var networkDataFetcher: DataFetcher
    var localDataService: LocalData
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher(), localDataService: LocalData = LocalDataService()) {
        self.networkDataFetcher = networkDataFetcher
        self.localDataService = localDataService
    }
    
    func fetchWeatherInCity(cityName: String, completion: @escaping (WeatherResponse?) -> Void) {
        let parameters: [String : String] = ["q" : cityName, "appid" : API.key, "lang" : API.language]
        networkDataFetcher.fetchGenericJSONData(path: API.getCityWeather, params: parameters, response: completion)
    }
    
    func fetchWeatherInCities(weatherToFetch: [WeatherResponse], completion: @escaping([WeatherResponse?]) -> Void) {
        var weatherInCities = [WeatherResponse?]()
        if weatherToFetch.isEmpty { return completion(weatherInCities)}
        
        let group = DispatchGroup()
        for i in 0..<weatherToFetch.count {
            group.enter()
            print("entering")
            fetchWeatherInCity(cityName: weatherToFetch[i].name) { (weather) in defer { group.leave() }
                guard let weatherInCity = weather else { return }
                weatherInCities.append(weatherInCity)
                print("Leaving")
            }
        }
        group.notify(queue: .main) {
            print(weatherInCities)
            completion(weatherInCities)
        }
    }
    
    func saveWeatherInCity(weather: WeatherResponse) {
        let key = UserDefaultKeys.savedWeather
        var weatherArray = localDataService.getArray(type: WeatherResponse.self, key: key)
        
        // if array is empty we add new element to save
        guard var loadedWeather = weatherArray else {
            weatherArray?.append(weather)
            self.localDataService.save(weatherArray, key: key)
            return
        }
        
        // checking does array have same weather item if it doesnt save weather
        let matchingIndex = loadedWeather.firstIndex(where: {$0.id == weather.id})
        guard let index = matchingIndex else {
            weatherArray?.append(weather)
            self.localDataService.save(weatherArray, key: key)
            return
        }
        
        // if array have same weather update it by it index
        loadedWeather.insert(weather, at: index)
    }
    
    func getWeatherArray() -> [WeatherResponse]? {
        let key = UserDefaultKeys.savedWeather
        let weatherArray = localDataService.getArray(type: WeatherResponse.self, key: key)
        guard let loadedWeather = weatherArray else { return nil }
        return loadedWeather
    }
    
    func deleteCity(weatherID: Int) -> [WeatherResponse]? {
        let key = UserDefaultKeys.savedWeather
        let weatherArray = localDataService.getArray(type: WeatherResponse.self, key: key)
        guard var loadedWeather = weatherArray else { return nil }
        
        let matchingIndex = loadedWeather.firstIndex(where: {$0.id == weatherID})
        guard let index = matchingIndex else { return nil }
        
        loadedWeather.remove(at: index)
        localDataService.save(loadedWeather, key: key)
        
        return loadedWeather
    }
    
}
