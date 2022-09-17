//
//  WeatherManager.swift
//  Clima
//
//  Created by Parth Antala on 2022-09-12.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation
protocol weatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel)
    func didFailedWithError(error: Error)
}
struct WeatherManager{
    
    var delegate: weatherManagerDelegate?
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=656a787368d0277aec1af8a18c5db6c8&units=metric"
    
    func fetchWeather(city: String){
        let urlString = "\(weatherURL)&q=\(city)"
        performRequest(url: urlString)
        
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitute: CLLocationDegrees){
        
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitute)"
        performRequest(url: urlString)
    }
    
    func performRequest(url: String){
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, responce, error in
                if error != nil{
                    delegate?.didFailedWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    print(safeData)
                    if let weather =  self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            print(name)
            let weather = WeatherModel(id: id, name: name, temp: temp)
            return weather
        } catch {
            delegate?.didFailedWithError(error: error)
            return nil
        }
    }
    
    
}
