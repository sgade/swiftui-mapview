//
//  MKMapView+MapViewAnnotation.swift
//  SwiftUIMapView
//
//  Created by Sören Gade on 21.02.20.
//

import MapKit

@available(iOS, introduced: 13.0)
extension MKMapView {
    
    /**
     All `MapAnnotations` set on the map view.
     */
    var mapViewAnnotations: [MapViewAnnotation] {
        annotations.compactMap { $0 as? MapViewAnnotation }
    }
    
    /**
     All `MapAnnotations` selected on the map view.
     */
    var selectedMapViewAnnotations: [MapViewAnnotation] {
        selectedAnnotations.compactMap { $0 as? MapViewAnnotation }
    }
    
}
