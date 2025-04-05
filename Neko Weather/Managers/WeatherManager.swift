//
//  Neko_WeatherApp.swift
//  Neko Weather
//
//  Created by Edwin Garcia on 6/18/24.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    private var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "OPENWEATHER_API_KEY") as? String else {
            fatalError("API Key not found in Info.plist")
        }
        return key
    }
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBodyWeather {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=imperial") else { fatalError("Missing URL")}
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error fetching waether data")}
        
        let decodedData = try JSONDecoder().decode(ResponseBodyWeather.self, from: data)
        
        return decodedData
    }
	func getWeatherForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBodyForecast {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=imperial") else { fatalError("Missing URL")}
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error fetching waether data")}
        
        let decodedData = try JSONDecoder().decode(ResponseBodyForecast.self, from: data)
        
        return decodedData
    }
}

struct ResponseBodyWeather: Decodable {
    var coord: CoordinateResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var wind: WindResponse
    var clouds: CloudResponse
    var dt: Double
    var name: String
    
    struct CoordinateResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
    struct CloudResponse: Decodable {
        var all: Double
    }
}

struct ResponseBodyForecast: Decodable {
	var cod: String
	var message: Int
	var cnt: Int
	var list: [ListResponse]
	
	struct ListResponse: Decodable {
		var dt: Double
		var main: MainResponse
		var weather: [WeatherResponse]
		var clouds: CloudsResponse
		var wind: WindResponse
		var visibility: Int
		var pop: Double
		var rain: RainResponse?
		var sys: SysResponse
		var dt_txt: String
		
		struct MainResponse: Decodable {
			var temp: Double
			var feels_like: Double
			var temp_min: Double
			var temp_max: Double
			var pressure: Double
			var sea_level: Double
			var grnd_level: Double
			var humidity: Double
			var temp_kf: Double
		}

		struct WeatherResponse: Decodable {
			var id: Double
			var main: String
			var description: String
			var icon: String
		}

		struct CloudsResponse: Decodable {
			var all: Double
		}

		struct WindResponse: Decodable {
			var speed: Double
			var deg: Double
			var gust: Double
		}

		struct RainResponse: Decodable {
			var three_h: Double?
			
			enum CodingKeys: String, CodingKey {
				case three_h = "3h"
			}
		}

		struct SysResponse: Decodable {
			var pod: String
		}
	}
}
