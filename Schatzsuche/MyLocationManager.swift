//
//  MyLocationManager.swift
//  Schatzsuche
//
//  Created by Benedikt Kurz on 18.03.19.
//  Copyright © 2019 Benedikt Kurz. All rights reserved.
//

import Foundation
import CoreLocation

class MyLocationManager:  NSObject, CLLocationManagerDelegate {
    
    
    static let sharedInstance = MyLocationManager()
    
    var locmgr = CLLocationManager()
    
    var heading:CLHeading!
    var location:CLLocation!
 
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        location = locmgr.location
        
        NotificationCenter.default.post(name: .init("NewLocation"), object: manager)
        
    }
    
    // didUpdate-Delegation
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        heading = locmgr.heading
        
        NotificationCenter.default.post(name: .init("HewHeading"), object: manager)
        
    }
    
    // bei Bedarf: Kalibrierung der Kompassnadel
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
    
    
    
    override init() {
        
        super.init()
        locmgr.delegate = self // as? CLLocationManagerDelegate
        locmgr.desiredAccuracy = kCLLocationAccuracyBest
        
        
        // UM Erlaubnis zu bekommen
        locmgr.requestWhenInUseAuthorization()
        
        // Location- und Heading-Ereignisse verarbeiten
        locmgr.startUpdatingLocation()
        locmgr.startUpdatingHeading()
        
    }

    
    
    
    
}
