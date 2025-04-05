//
//  Neko_WeatherApp.swift
//  Neko Weather
//
//  Created by Edwin Garcia on 6/18/24.
//

import SwiftUI

struct ContentView: View {
	@StateObject var locationManager = LocationManager()
	@State var weather: ResponseBodyWeather?
	@State var forecast: ResponseBodyForecast?
	var weatherManager = WeatherManager()
	
	var body: some View {
		VStack {
			if let location = locationManager.location {
				if let weather = weather, let forecast = forecast {
					WeatherView(weather: weather, forecast: forecast)
				} else {
					LoadingView()
						.task {
							do {
								async let weatherData = weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
								async let forecastData = weatherManager.getWeatherForecast(latitude: location.latitude, longitude: location.longitude)
								
								weather = try await weatherData
								forecast = try await forecastData
							} catch {
								print("Error getting weather: \(error)")
							}
						}
				}
			} else {
				if locationManager.isLoading {
					LoadingView()
				} else {
					WelcomeView()
						.environmentObject(locationManager)
				}
			}
		}
		.background(Color(red: 1.0, green: 0.765, blue: 0.851))
		.preferredColorScheme(.dark)
	}
}

#Preview {
	ContentView()
}
