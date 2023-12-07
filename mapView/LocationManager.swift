//
//  LocationManager.swift
//  mapView
//
//  Created by dhf on 7/12/2023.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    override private init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // or another accuracy level
    }

    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization() // or requestAlwaysAuthorization, based on your need
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    // CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Handle location updates
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Handle authorization changes
    }
}

