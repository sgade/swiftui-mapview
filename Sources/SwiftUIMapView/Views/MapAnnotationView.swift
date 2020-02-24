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
            if let mapAnnotation = newValue as? MapAnnotation {
                self.clusteringIdentifier = mapAnnotation.clusteringIdentifier
                self.markerTintColor = mapAnnotation.tintColor
                self.glyphImage = mapAnnotation.glyphImage
            }
        }
    }
    
}
