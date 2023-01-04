//
//  WeatherManager.swift
//  WeatherAppSwift
//
//  Created by Emre ÖZKÖK on 3.01.2023.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager ,weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager{
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(SecretKey.apiKey)&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fethWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let result = data{
                    let decoder = JSONDecoder()
                    DispatchQueue.main.async {
                        do{
                            let decodedData = try decoder.decode(WeatherData.self, from: result)
                            let id = decodedData.weather[0].id
                            let city = decodedData.name
                            let temperature = decodedData.main.temp
                            
                            let weatherModel = WeatherModel(conditionId: id, cityName: city, temperature: temperature)
                            self.delegate?.didUpdateWeather(self, weather: weatherModel)
                        }catch{
                            delegate?.didFailWithError(error: error)
                            return
                        }
                    }
                    
                }
            }
            task.resume()
        }
    }
    
   
}
