//
//  Neko_WeatherApp.swift
//  Neko Weather
//
//  Created by Edwin Garcia on 6/18/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .shadow(color: .black, radius: 10)
    }
}

#Preview {
    LoadingView()
}
