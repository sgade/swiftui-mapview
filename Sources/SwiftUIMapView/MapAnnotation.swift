//
//  MapAnnotation.swift
//  SwiftUIMapView
//
//  Created by Sören Gade on 19.02.20.
//  Copyright © 2020 Sören Gade. All rights reserved.
//

import Foundation
import MapKit

/**
 An annotation on a `MapView`. Annotations can be visualized using their `title`, `subtitle`, `glyphImage` and `tintColor`.
 
 To support automatic clustering of annotations, specify a `clusterIdentifier`.
 
 Note: `MapAnnotation` provides a custom view class implementation for displaying the annotation data on the map. Custom views are currently not supported.
 
 - Author: Sören Gade
 - Copyright: 2020 Sören Gade
 */
@available(iOS, introduced: 13.0)
public protocol MapViewAnnotation: MKAnnotation {
    
    /**
     Identifier for clustering annotations. Setting to a non-`nil` value marks the annotation as participant in clustering.
     
    - SeeAlso: MKAnnotationView.clusteringIdentifier
     */
    var clusteringIdentifier: String? {
        get
    }
    
    /**
     The image to display as a glyph in the annotation's view.
     */
    var glyphImage: UIImage? {
        get
    }
    
    /**
     The tint color of the annotations's view.
     */
    var tintColor: UIColor? {
        get
    }
    
}
