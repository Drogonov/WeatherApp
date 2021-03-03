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
        static let savedTemperature = "savedTemperature"
    }
    
    var networkDataFetcher: DataFetcher
    var localDataService: LocalData
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher(), localDataService: LocalData = LocalDataService()) {
        self.networkDataFetcher = networkDataFetcher
        self.localDataService = localDataService
    }
    
    func fetchWeatherInCity(cityName: String, completion: @escaping (WeatherResponse?) -> Void) {
        trackEnterFunc(describing: self, values: [cityName, completion])
        
        let parameters: [String : String] = ["q" : cityName, "appid" : API.key, "lang" : API.language]
        networkDataFetcher.fetchGenericJSONData(path: API.getCityWeather, params: parameters, response: completion)
    }
    
    func fetchWeatherInCities(weatherToFetch: [WeatherResponse], completion: @escaping([WeatherResponse?]) -> Void) {
        trackEnterFunc(describing: self, values: [weatherToFetch, completion])
        
        var weatherInCities = [WeatherResponse?]()
        if weatherToFetch.isEmpty { return completion(weatherInCities)}
        
        let group = DispatchGroup()
        for i in 0..<weatherToFetch.count {
            group.enter()
            print("Entering")
            fetchWeatherInCity(cityName: weatherToFetch[i].name) { (weather) in defer { group.leave()
                print("Leaving") }
                guard let weatherInCity = weather else { return }
                weatherInCities.append(weatherInCity)
            }
        }
        group.notify(queue: .main) {
            let weatherSorted = weatherInCities.sorted {
                $0?.id ?? 0 < $1?.id ?? 1
            }
            self.saveWeatherInCities(fetchedWeather: weatherSorted)
            trackFuncCompletion(describing: self, values: weatherSorted)
            completion(weatherSorted)
        }
    }
    
    func saveWeatherInCities(fetchedWeather: [WeatherResponse?]) {
        let key = UserDefaultKeys.savedWeather
        localDataService.save(fetchedWeather, key: key)
    }
    
    func saveWeatherInCity(weather: WeatherResponse) {
        trackEnterFunc(describing: self, values: [weather])
        
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
        trackEnterFunc(describing: self)
        
        let key = UserDefaultKeys.savedWeather
        let weatherArray = localDataService.getArray(type: WeatherResponse.self, key: key)
        trackFuncCompletion(describing: self, values: [weatherArray])
        return weatherArray
    }
    
    func deleteCity(weatherID: Int) -> [WeatherResponse]? {
        trackEnterFunc(describing: self, values: [weatherID])
        
        let key = UserDefaultKeys.savedWeather
        let weatherArray = localDataService.getArray(type: WeatherResponse.self, key: key)
        guard var loadedWeather = weatherArray else { return nil }
        
        let matchingIndex = loadedWeather.firstIndex(where: {$0.id == weatherID})
        guard let index = matchingIndex else { return nil }
        
        loadedWeather.remove(at: index)
        localDataService.save(loadedWeather, key: key)
        
        return loadedWeather
    }
    
    func getTempType() -> TemperatureSettings {
        trackEnterFunc(describing: self)
        
        let key = UserDefaultKeys.savedTemperature
        let temp = UserDefaults.standard.value(forKey: key)
        return TemperatureSettings(rawValue: temp as! String) ?? .celsius
    }
    
    func saveTempType(temp: TemperatureSettings) {
        trackEnterFunc(describing: self, values: [temp])
        
        let key = UserDefaultKeys.savedTemperature
        UserDefaults.standard.setValue(temp.rawValue, forKey: key)
    }
    
}
