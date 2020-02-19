//
//  MapAnnotationView.swift
//  swiftui-mapview
//
//  Created by Sören Gade on 19.02.20.
//  Copyright © 2020 Sören Gade. All rights reserved.
//

import Foundation
import MapKit

class MapAnnotationView: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            if let mapAnnotation = newValue as? MapAnnotation {
                // optionally enable clustering. The hint to use this identifier came from an Apple example project
                // which was mentioned in a second (but not accepted) answer on StackOverflow: https://stackoverflow.com/a/45878868/2517996
                self.clusteringIdentifier = mapAnnotation.clusterIdentifier
                self.markerTintColor = mapAnnotation.tintColor
                self.glyphImage = mapAnnotation.glyphImage
            }
        }
    }
    
}
