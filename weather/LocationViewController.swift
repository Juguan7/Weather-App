//
//  LocationViewController.swift
//  Mobile Weather App
//
//  
//
import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var curLocation: String = ""
    var loaded: Bool = false
    var fcLVM: ForecastListViewModel? = Optional.none
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = manager.location else { return }
        fetchCityAndCountry(from: location) { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            self.changeCurLocation(location: (city + ", " + country))
            self.setVMLocation()
            print("hi " + self.curLocation)
        }
    }
    
    func changeCurLocation(location: String){
        curLocation = location
        print("here " + location)
        print("here 2 " + curLocation)
    }
    
    func getCurLocation() -> String{
        print("get " + curLocation)
        return curLocation
    }

    func toggleLoad(){
        loaded = true
    }
    
    func setVMLocation(){
        fcLVM?.location = curLocation
        fcLVM?.getWeatherForecast()
    }
    
    func setVM(vm: ForecastListViewModel){
        fcLVM = vm
    }
}
