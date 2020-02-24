//
//  MKMapView+MapAnnotation.swift
//  SwiftUIMapView
//
//  Created by Sören Gade on 21.02.20.
//

import MapKit

extension MKMapView {
    
    /**
     All `MapAnnotations` set on the map view.
     */
    var mapAnnotations: [MapAnnotation] {
        self.annotations.filterMapAnnotations()
    }
    
    /**
     All `MapAnnotations` selected on the map view.
     */
    var selectedMapAnnotations: [MapAnnotation] {
        self.selectedAnnotations.filterMapAnnotations()
    }
    
}

extension Array where Element: MKAnnotation {
    
    /**
     Filters the elements to only include `Element`s of type `MapAnnotation`.
     
     - SeeAlso: MapAnnotation
     */
    func filterMapAnnotations() -> [MapAnnotation] {
        self.filter { $0 is MapAnnotation }
            .map { $0 as! MapAnnotation }
    }
    
}
