//
//  CLLocationCoordinate2D+Examples.swift
//  MapViewExample
//
//  Created by Sören Gade on 21.02.20.
//

import CoreLocation

extension CLLocationCoordinate2D {
    
    static var inifiniteLoop: CLLocationCoordinate2D = {
        CLLocationCoordinate2D(latitude: 37.331836, longitude: -122.029604)
    }()
    
    static var applePark: CLLocationCoordinate2D = {
        CLLocationCoordinate2D(latitude: 37.334780, longitude: -122.009073)
    }()
    
}
