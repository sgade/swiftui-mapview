//
//  CoreLocation+Equatable.swift
//  SwiftUIMapView
//
//  Created by Sören Gade on 24.02.20.
//

import MapKit.MKGeometry

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.latitude == rhs.latitude
            && lhs.longitude == rhs.longitude
    }
}

extension MKCoordinateSpan: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.latitudeDelta == rhs.latitudeDelta
            && lhs.longitudeDelta == rhs.longitudeDelta
    }
}

extension MKCoordinateRegion: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.center == rhs.center
            && lhs.span == rhs.span
    }
}
