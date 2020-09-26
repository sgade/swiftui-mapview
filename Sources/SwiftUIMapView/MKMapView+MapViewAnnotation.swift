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
        self.annotations.filterMapAnnotations()
    }
    
    /**
     All `MapAnnotations` selected on the map view.
     */
    var selectedMapViewAnnotations: [MapViewAnnotation] {
        self.selectedAnnotations.filterMapAnnotations()
    }
    
}

@available(iOS, introduced: 13.0)
extension Array where Element: MKAnnotation {
    
    /**
     Filters the elements to only include `Element`s of type `MapAnnotation`.
     
     - SeeAlso: MapAnnotation
     */
    func filterMapAnnotations() -> [MapViewAnnotation] {
        self.filter { $0 is MapViewAnnotation }
            .map { $0 as! MapViewAnnotation }
    }
    
}
