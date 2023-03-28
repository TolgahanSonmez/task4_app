//
//  CityWeatherData.swift
//  WeatherApp
//
//  Created by Tolgahan Sonmez on 8.03.2023.
//

import Foundation

struct CityWeatherData: Decodable {
    let cod : String
    let list : [List]
    let city : City
}

struct List : Decodable {
    let main : Main
    let weather : [Weather]
    let dt_txt : String
    
}

struct City : Decodable {
    let name : String
    let country : String
    let population : Int
    let timezone : Int
}

