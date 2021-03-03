//
//  Track Functions.swift
//  WeatherApp
//
//  Created by Admin on 03.03.2021.
//

import Foundation

public func trackEnterFunc(describing: Any, function: String = #function, line: Int = #line, values: [Any?]? = nil) {
    if values != nil {
        print("Enter \(describing) func \(function) line:\(line) with values: \(values!)")
    } else {
        print("Enter \(describing) func \(function) line:\(line)")
    }
}

public func trackFuncData(describing: Any, function: String = #function, line: Int = #line, values: [Any?]) {
    print("Track data in \(describing) func \(function) line:\(line) with values: \(values)")
}

public func trackFuncCompletion(describing: Any, function: String = #function, line: Int = #line, values: [Any?]) {
    print("Competion \(describing) func \(function) line:\(line) with values: \(values)")
}
