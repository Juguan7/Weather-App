//
//  ContentView.swift
//  weather
//
//  
//

import SwiftUI

struct ContentView: View {
//    @StateObject var currentWeatherVM = CurrentWeatherViewModel()
    @StateObject var forecastListVM = ForecastListViewModel()

    var body: some View {
        VStack{
//            ScrollView {
//                Group {
//                    Text("CURRENTLY:")
//                    Text(("City: " + (currentWeatherVM.currentWeather?.name ?? "")))
//                    Text("Lon: \(currentWeatherVM.lastLocation?.coordinate.longitude ?? 0)")
//                    Text("Lat: \(currentWeatherVM.lastLocation?.coordinate.latitude ?? 0)")
//
//                    Text(("Weather: " + (currentWeatherVM.currentWeather?.weather[0].main ?? "Loading...")) )
//                    Text(("Temperature: " + (String(currentWeatherVM.currentWeather?.main.temp ?? 0.0) )) )
//                    Text(("Humidity: " + (String(currentWeatherVM.currentWeather?.main.humidity ?? Int(0.0)) )) )
//                    Text(("Wind Speed: " + (String(currentWeatherVM.currentWeather?.wind.speed ?? 0.0) )) )
//                }
//            }
            HStack {
                TextField("Enter Location", text: $forecastListVM.location,
                          onCommit: {
                            forecastListVM.getWeatherForecast()
                          })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay (
                        Button(action: {
                            forecastListVM.location = ""
                            forecastListVM.getWeatherForecast()
                        }) {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal),
                        alignment: .trailing
                    )
                Button {
                    forecastListVM.getWeatherForecast()
                } label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.title3)
                }
            }
//            if(forecastListVM.loadedForeCasts()){
//                VStack(alignment: .leading) {
//                    Text(forecastListVM.getForecastByDay(numDay: 0).day)
//                        .fontWeight(.bold)
//                    HStack(alignment: .center) {
////                                    WebImage(url: day.weatherIconURL)
////                                        .resizable()
////                                        .placeholder {
////                                            Image(systemName: "hourglass")
////                                        }
////                                        .scaledToFit()
////                                        .frame(width: 75)
//                        VStack(alignment: .leading) {
//                            Text(forecastListVM.getForecastByDay(numDay: 0).overview)
//                                .font(.title2)
//                            HStack {
//                                Text(forecastListVM.getForecastByDay(numDay: 0).high)
//                                Text(forecastListVM.getForecastByDay(numDay: 0).low)
//                            }
//                            HStack {
//                                Text(forecastListVM.getForecastByDay(numDay: 0).clouds)
//                                Text(forecastListVM.getForecastByDay(numDay: 0).pop)
//                            }
// Text(forecastListVM.getForecastByDay(numDay: 0).humidity)
//                        }
//                    }
//                }
//            }
            if(forecastListVM.loadedForeCasts()){
                WeatherView(forecastlistVM: forecastListVM)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
