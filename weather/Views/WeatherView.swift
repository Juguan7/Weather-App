//
//  WeatherView.swift
//  weather
//
//  
//

import SwiftUI

struct WeatherView: View {
    //@State var isSearching: Bool
    let forecastlistVM : ForecastListViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                VStack(spacing:5){
                    Text(forecastlistVM.location)
                    Text(forecastlistVM.getForecastByDay(numDay: 0).day)
                    Text(forecastlistVM.getForecastByDay(numDay: 0).overview)
                    AsyncImage(url:forecastlistVM.getForecastByDay(numDay: 0).weatherIconURL)
                }
                Spacer()
                    .frame(width: 60, height: 60)
//                ScrollView(.horizontal, showsIndicators: false){
//                    HStack(spacing: 10){
//                        ForEach(1..<20){i in
//                            VStack(spacing: 5){
//                                Text("Time")
//                                Image(systemName: "sun.max.fill")
//                                Text("9")
//                            }
//                        }
//                    }
//                }
                .frame(width: 285)
                VStack(spacing: 10){
                    HStack(spacing: 145){
                        Text("Date")
                            .offset(x:-5)
                        Text("Temperature")
                            .offset(x:-5)
                    }
                    
                    ForEach(0..<7){ i in
                        HStack(spacing: 15){
                            Text(forecastlistVM.getForecastByDay(numDay: i).day)
                                .frame(width: 100, alignment: .leading)
                            AsyncImage(url:forecastlistVM.getForecastByDay(numDay: i).weatherIconURL)
                                .scaleEffect(0.5)
                                .frame(width:50, height:50)
                                .scaledToFit()
                            Text(forecastlistVM.getForecastByDay(numDay: i).high)
                            Text(forecastlistVM.getForecastByDay(numDay: i).low)
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .background(Color.cyan)
//                        .toolbar{
//                            ToolbarItem(placement: .navigationBarTrailing){
//                                Button{
//                                }label:{
//                                    Image(systemName: "magnifyingglass")
//                                        .foregroundColor(Color.black)
//                                } 
//                            }
//                        }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        let fclVM : ForecastListViewModel = ForecastListViewModel()
        if (fclVM.loadedForeCasts()){
            WeatherView(forecastlistVM: fclVM)
        }
        
    }
}
