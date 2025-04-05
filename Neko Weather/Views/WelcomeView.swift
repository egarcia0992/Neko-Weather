//
//  Neko_WeatherApp.swift
//  Neko Weather
//
//  Created by Edwin Garcia on 6/18/24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack{
            VStack(spacing: 20) {
                Text("Welcom to the Weather App")
                    .bold().font(.title)
                
                Text("Please share your location to get weather location")
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation){
				locationManager.requestLocation()
            }
            .cornerRadius(10.0)
            .symbolVariant(.fill)
            .foregroundColor(.white)
            .tint(Color(red: 1.0, green: 0.565, blue: 0.737))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WelcomeView()
}
