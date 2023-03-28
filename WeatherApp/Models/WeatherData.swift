//
//  Weather.swift
//  WeatherApp
//
//  Created by Tolgahan Sonmez on 7.03.2023.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Float
    let feels_like : Float
    let temp_max : Float
    let temp_min : Float
}

struct Weather: Decodable {
    let id: Int
    let main : String
    let icon : String
}
