//
//  CoreLocation+Equatable.swift
//  SwiftUIMapView
//
//  Created by Sören Gade on 24.02.20.
//

import Foundation
import CoreLocation
import MapKit

// MARK: - CLLocationCoordinate2D

extension CLLocationCoordinate2D: @retroactive Equatable {

    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }

}

// MARK: - MKCoordinateSpan

extension MKCoordinateSpan: @retroactive Equatable {

    public static func ==(lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
        lhs.latitudeDelta == rhs.latitudeDelta && lhs.longitudeDelta == rhs.longitudeDelta
    }

}
