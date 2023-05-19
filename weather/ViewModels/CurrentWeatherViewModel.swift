//
//  CurrentWeatherViewModel.swift
//  weather
//
//  
//

import CoreLocation
import Foundation
import Combine

class CurrentWeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
 
    @Published var currentWeather: CurrentWeather? = nil
    private let locationService = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    
    override init() {
        super.init()
        locationService.delegate = self
        locationService.desiredAccuracy = kCLLocationAccuracyBest
        locationService.requestWhenInUseAuthorization()
        locationService.startUpdatingLocation()
    }
    
    var statusString: String  {
        guard let status = locationStatus else {
            return "unknown"
        }
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        lastLocation = location
        print(#function, location)
        Task {
            let longitude = location.coordinate.longitude
            let latitude = location.coordinate.latitude
            await self.loadCurrentWeather(lat: latitude, lon: longitude)
        }
    }
    
    @MainActor func loadCurrentWeather(lat: Double, lon: Double) async {
        if Task.isCancelled{
            return
        }

        if let currentWeather = await WeatherAPIService.getCurrentWeather(lat: lat, lon: lon) {
            self.currentWeather = currentWeather
        }
        
    }
}
