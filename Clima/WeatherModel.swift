//
//  WeatherModel.swift
//  Clima
//
//  Created by Parth Antala on 2022-09-12.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel {
    let id: Int
    let name: String
    let temp: Double
    
    var tempString: String{
        return String(format: "%.1f", temp)
    }
    var conditionName: String {
        switch id {
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
