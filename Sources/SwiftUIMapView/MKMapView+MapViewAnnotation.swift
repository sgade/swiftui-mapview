//
//  MKMapView+MapViewAnnotation.swift
//  SwiftUIMapView
//
//  Created by Sören Gade on 21.02.20.
//

import MapKit

extension MKMapView {

    /// All ``MapViewAnnotation``s set on the map view.
    var mapViewAnnotations: [MapViewAnnotation] {
        annotations.compactMap { $0 as? MapViewAnnotation }
    }

    /// All ``MapViewAnnotation``s selected on the map view.
    var selectedMapViewAnnotations: [MapViewAnnotation] {
        selectedAnnotations.compactMap { $0 as? MapViewAnnotation }
    }
    
}
