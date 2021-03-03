//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {

    // построение запроса данных по URL
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void) {
        trackEnterFunc(describing: self, values: [path, params, completion])
        let url = self.url(from: path, params: params)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from requst: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        trackEnterFunc(describing: self, values: [requst, completion])
        return URLSession.shared.dataTask(with: requst, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                trackFuncCompletion(describing: self, values: [data, error])
                completion(data, error)
            }
        })
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        trackEnterFunc(describing: self, values: [path, params])
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map {  URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
}
