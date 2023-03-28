//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Tolgahan Sonmez on 8.03.2023.
//

import Foundation

struct WeatherViewModel {
    let cityName : String
    let temp : Float
    let weatherConditions : String
    let maxTemp : Float
    let minTemp : Float
    
    var stringTemp : String {
        return String(format: "%.1f", temp)
    }
    
    var stringMaxTemp : String {
        return String(format: "%.1f", maxTemp)
    }
    
    var stringMinTemp : String {
        return String(format: "%.1f", minTemp)
    }
    
    
    
}
