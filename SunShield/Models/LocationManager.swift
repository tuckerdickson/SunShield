//
//  LocationManager.swift
//  SunShield
//
//  Created by Tucker Dickson on 7/1/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    // MARK: Properties
    @Published var manager: CLLocationManager = .init()
    
    public var location: CLLocation = .init()
    public var city: String = "Cupertino"
    public var state: String = "CA"
    
    override init() {
        super.init()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization() // TODO: change this to always?
        
        if manager.authorizationStatus == .authorizedAlways ||
            manager.authorizationStatus == .authorizedWhenInUse {
            location = manager.location ?? CLLocation(latitude: 37.322998, longitude: 122.032181)
            lookUpCurrentLocation()
        }
        
    }
    
    // MARK: Reverse geocoding
    func lookUpCurrentLocation() {
        let geocoder = CLGeocoder()        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                return
            }
            
            self.city = place.locality ?? self.city
            self.state = place.administrativeArea ?? self.state
        }
    }
    
    func handleLocationError() {
        // TODO: HANDLE ERROR
    }
}

extension LocationManager: CLLocationManagerDelegate {
    // MARK: Location Authorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:     manager.requestLocation()
        case .authorizedWhenInUse:  manager.requestLocation()
        case .notDetermined:        manager.requestWhenInUseAuthorization()
        case .denied:               handleLocationError()
        default: ()                 // TODO: figure this out
        }
    }
    
    // MARK: Did update locations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lookUpCurrentLocation()
        location = locations.last ?? CLLocation(latitude: 37.322998, longitude: 122.032181)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: HANDLE ERROR
    }
}


