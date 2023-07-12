//
//  LocationManager.swift
//  SunShield
//
//  Created by Tucker Dickson on 7/1/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
   
    @Published var authorizationStatus: CLAuthorizationStatus?
    private let locationManager = CLLocationManager()
    var location: CLLocation {
        locationManager.location ?? CLLocation(latitude: 37.322998, longitude: 122.032181)
    }
    
    var city: String?
    var state: String?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    // determines the city and state name for a (lat,long) location
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
    
    // called when the user's location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }
    
    // called when the location authorization status is changed
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch manager.authorizationStatus {
        // authorized; get the user's location
        case .authorizedWhenInUse:
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            lookUpCurrentLocation(for: location)
            break
            
        // restricted; don't do anything
        case .restricted:
            authorizationStatus = .restricted
            break
        
        // denied; don't do anything
        case .denied:
            authorizationStatus = .denied
            break
            
        // not determined; request authorization
        case .notDetermined:
            authorizationStatus = .notDetermined
            locationManager.requestWhenInUseAuthorization()
            break
            
        // all other cases; don't do anything
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
    }
}


