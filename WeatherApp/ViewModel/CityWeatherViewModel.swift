//
//  CityWeatherViewModel.swift
//  WeatherApp
//
//  Created by Tolgahan Sonmez on 10.03.2023.
//

import Foundation

struct CityWeatherViewModel{
    let temperature: Float
    
    var temperatureString: String {
        return String(format: "%.1f", temperature) + "°"
    }
    
    let conditionID: Int
    
    var weatherCondion: String{
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
   
}
    

