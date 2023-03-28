//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by Tolgahan Sonmez on 6.03.2023.
//

import Foundation

class WeatherApi{
    static let shared = WeatherApi()
    
    struct Constants{
        static let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=dd6556b4297722f60525260420e074c6&units=metric"
        
    }
    
    enum APIError : Error {
        case failedToGetData
    }
    
    
    enum HTTPMethod : String {
        case GET
        case PUT
        case POST
        case DELETE
        
    }
    
    private func createRequest(
        with url : URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest)->Void)
    {
        guard let apiUrl = url else {return}
        var request = URLRequest(url: apiUrl)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
    
    public func getMyLocationWeather(latitude lat: Float, longitude lon: Float, completion : @escaping (Result<WeatherData,Error>)->Void){
        createRequest(with: URL(string: "\(Constants.weatherURL)&lat=\(lat)&lon=\(lon)"),
                      type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data , error == nil else
                {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do
                {
                    let result = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(.success(result))
                    print(result)
                }
                catch
                {
                    completion(.failure(error))
                    print("Eror: \(error)")
                }
            }
            task.resume()
        }
    }
    
    public func getCitiesWeather(cityName : String, completion: @escaping (Result<CityWeatherData,Error>) -> Void) {
        createRequest(with: URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=dd6556b4297722f60525260420e074c6&units=metric&exclude=daily"),
                      type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do
                {
                    let result = try JSONDecoder().decode(CityWeatherData.self, from: data)
                    completion(.success(result))
                }
                catch
                {
                    completion(.failure(error))
                    print("getCitiesWeather'dan gelen eror \(error)")
                }
            }
            task.resume()
        }
    }
    
}
