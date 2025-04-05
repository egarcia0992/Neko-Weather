//
//  Neko_WeatherApp.swift
//  Neko Weather
//
//  Created by Edwin Garcia on 6/18/24.
//

import Foundation

func load<T: Decodable>(_ filename: String, bundle: Bundle = .main) -> T {
	let data: Data

	guard let file = bundle.url(forResource: filename, withExtension: nil) else {
		fatalError("Couldn't find \(filename) in bundle.")
	}

	do {
		data = try Data(contentsOf: file)
	} catch {
		fatalError("Couldn't load \(filename) from bundle:\n\(error)")
	}

	do {
		let decoder = JSONDecoder()
		return try decoder.decode(T.self, from: data)
	} catch {
		fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
	}
}

let previewWeather: ResponseBodyWeather = load("weatherData.json")
let previewForecast: ResponseBodyForecast = load("forecastData.json")
