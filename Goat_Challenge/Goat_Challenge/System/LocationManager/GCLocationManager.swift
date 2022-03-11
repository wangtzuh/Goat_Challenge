//
//  GCLocationManager.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/11/22.
//

import Foundation
import CoreLocation

protocol GCLocationManagerProtocol {
    func registerObserver(_ delegate: GCLocationManagerDelegate)
    func requestLocation()
    func stopRequestingLocation()
}


class GCLocationManager: NSObject, GCLocationManagerProtocol {
    
    private weak var delegate: GCLocationManagerDelegate?
    private var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
    }
    
    func registerObserver(_ delegate: GCLocationManagerDelegate) {
        self.delegate = delegate
    }
    
    func requestLocation() {
        guard let manager = locationManager, CLLocationManager.locationServicesEnabled() else {
            delegate?.gclocationManager(self, isPermissionGranted: false)
            return
        }
        manager.requestAlwaysAuthorization()
    }
    
    func stopRequestingLocation() {
        guard let manager = locationManager else {
            return
        }
        manager.stopUpdatingLocation()
    }
}

// MARK: - CLLocationManager Delegate
extension GCLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationData = LocationData(latitude: locations[0].coordinate.latitude,
                                        longitude: locations[0].coordinate.longitude)
        delegate?.gclocationManager(self, didReceiveLocationData: locationData)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            manager.requestLocation()
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:
            delegate?.gclocationManager(self, isPermissionGranted: false)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
