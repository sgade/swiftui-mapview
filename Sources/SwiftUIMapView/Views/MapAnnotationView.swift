//
//  MapAnnotationView.swift
//  SwiftUIMapView
//
//  Created by Sören Gade on 19.02.20.
//  Copyright © 2020 Sören Gade. All rights reserved.
//

import Foundation
import MapKit

/**
 Custom annotation view for `MapAnnotation` objects.
 
 Sets the view's `glyphImage` and `markerTintColor` according to values of the annotation.
 Automatically takes advantage of clustering via an optionally set `clusteringIdentifier`.
 */
class MapAnnotationView: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let mapAnnotation = newValue as? MapViewAnnotation else {
                return
            }

            clusteringIdentifier = mapAnnotation.clusteringIdentifier
            markerTintColor = mapAnnotation.tintColor
            glyphImage = mapAnnotation.glyphImage
        }
    }
    
}
