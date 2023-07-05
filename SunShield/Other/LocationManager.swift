//
//  LocationManager.swift
//  SunShield
//
//  Created by Tucker Dickson on 7/1/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
   
    private let locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var currentLocation: CLLocation?
    
    var city: String?
    var state: String?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func lookUpCurrentLocation(for location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                return
            }
            
            self.city = place.locality
            self.state = place.administrativeArea
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        currentLocation = location
        lookUpCurrentLocation(for: location)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
    }
}


