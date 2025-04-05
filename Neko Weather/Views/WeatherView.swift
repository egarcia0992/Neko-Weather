//
//  Neko_WeatherApp.swift
//  Neko Weather
//
//  Created by Edwin Garcia on 6/18/24.
//

import SwiftUI

struct WeatherView: View {
	var weather: ResponseBodyWeather
	var forecast: ResponseBodyForecast

	var body: some View {
		ZStack(alignment: .leading){
			VStack{
				VStack(alignment: .leading, spacing: 5){
					
					Text(weather.name).bold().font(.title)
					
					Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))").bold()
				}
				.padding(.leading)
				.frame(maxWidth: .infinity, alignment: .leading)
				
				Spacer()
				
				VStack{
					HStack{
						VStack(spacing: 20){
							Image(systemName: weatherIcon(for: weather.weather[0].icon))
								.font(.system(size: 50))
						}
						.frame(width: 150, alignment: .leading)
						
						Text("\(weather.main.temp.roundDouble())°")
							.font(.system(size: 100))
							.fontWeight(.bold)
					}
					VStack {
						HStack{
							VStack{
								Text("Feels Like \(weather.main.feels_like.roundDouble())°").padding().frame(maxWidth: .infinity).fontWeight(.bold)
							}.background(Color(red: 1.0, green: 1.0, blue: 1.0))
								.cornerRadius(10)
							VStack{
								Text("Humidity \(weather.main.humidity.roundDouble())%").padding().frame(maxWidth: .infinity).fontWeight(.bold)
							}.background(Color(red: 1.0, green: 1.0, blue: 1.0))
								.cornerRadius(10)
						}
						HStack{
							VStack{
								Text("Wind \(weather.wind.speed.roundDouble())mph").padding().frame(maxWidth: .infinity).fontWeight(.bold)
							}.background(Color(red: 1.0, green: 1.0, blue: 1.0))
								.cornerRadius(10)
							VStack{
								Text("Pressure \(weather.main.pressure.roundDouble())psi").padding().frame(maxWidth: .infinity).fontWeight(.bold)
							}.background(Color(red: 1.0, green: 1.0, blue: 1.0))
								.cornerRadius(10)
						}
					}
					.foregroundColor(Color(red: 1.0, green: 0.765, blue: 0.851))
					.padding(10)
					
					ScrollView(.horizontal, showsIndicators: false) {
						HStack {
							ForEach(forecast.list, id: \.dt) { item in
								VStack{
									Text("\(Date(timeIntervalSince1970: TimeInterval(item.dt)).formatted(.dateTime.hour()))")
									Text("\(item.main.temp.roundDouble())°F")
									Image(systemName: weatherIcon(for: item.weather[0].icon))
										.frame(height: 50).font(.system(size: 50))
									
								}.padding()
							}
						}
					}
					.frame(maxWidth: 500)
					
					Spacer()
				}
				.frame(maxWidth: .infinity)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
		}
		.background(Color(red: 1.0, green: 0.765, blue: 0.851))
		.preferredColorScheme(.dark)
	}
	func weatherIcon(for icon: String) -> String {
		switch icon {
		case "01d":
			return "sun.max.fill"
		case "01n":
			return "moon.fill"
		case "02d":
			return "cloud.sun.fill"
		case "02n":
			return "cloud.moon.fill"
		case "03d", "03n":
			return "cloud.fill"
		case "04d", "04n":
			return "smoke.fill"
		case "09d", "09n":
			return "cloud.drizzle.fill"
		case "10d":
			return "cloud.sun.rain.fill"
		case "10n":
			return "cloud.moon.rain.fill"
		case "11d", "11n":
			return "cloud.bolt.fill"
		case "13d", "13n":
			return "cloud.snow.fill"
		case "50d", "50n":
			return "cloud.fog.fill"
		default:
			return "questionmark.circle"
		}
	}
}

#Preview {
	WeatherView(weather: previewWeather, forecast: previewForecast)
}
