//
//  LocalDataService.swift
//  WeatherApp
//
//  Created by Admin on 01.03.2021.
//

import Foundation

protocol LocalData {
    func save<T: Codable>(_ value: T, key: String)
    func get<T: Codable>(type: T.Type, key: String) -> T?
    func getArray<T: Codable>(type: T.Type, key: String) -> [T]?
    func remove(key: String)
}

class LocalDataService: LocalData {
    
    let userDefaults = UserDefaults.standard
    
    func save<T: Codable>(_ value: T, key: String) {
        trackEnterFunc(describing: self, values: [value, key])
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }

    func get<T: Codable>(type: T.Type, key: String) -> T? {
        trackEnterFunc(describing: self, values: [type, key])
        var userData: T
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
        do {
            userData = try PropertyListDecoder().decode(type, from: data)
            trackFuncCompletion(describing: self, values: [userData])
            return userData
        } catch {
            print(error)
            return nil
        }
    }
    
    func getArray<T: Codable>(type: T.Type, key: String) -> [T]? {
        trackEnterFunc(describing: self, values: [type, key])
        var userData = [T]()
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return userData }
        do {
            userData = try PropertyListDecoder().decode([T].self, from: data)
            trackFuncCompletion(describing: self, values: [userData])
            return userData
        } catch {
            print(error)
            return nil
        }
    }

    func remove(key: String) {
        trackEnterFunc(describing: self, values: [key])
        UserDefaults.standard.removeObject(forKey: key)
    }
}
