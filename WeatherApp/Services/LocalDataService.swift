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
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }

    func get<T: Codable>(type: T.Type, key: String) -> T? {
        var userData: T
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
        do {
            userData = try PropertyListDecoder().decode(type, from: data)
            return userData
        } catch {
            print(error)
            return nil
        }
    }
    
    func getArray<T: Codable>(type: T.Type, key: String) -> [T]? {
        var userData: [T]
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
        do {
            userData = try PropertyListDecoder().decode([T].self, from: data)
            return userData
        } catch {
            print(error)
            return nil
        }
    }

    func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
