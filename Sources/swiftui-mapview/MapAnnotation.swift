//
//  MapAnnotation.swift
//  swiftui-mapview
//
//  Created by Sören Gade on 19.02.20.
//  Copyright © 2020 Sören Gade. All rights reserved.
//

import Foundation
import MapKit

protocol MapAnnotation: MKAnnotation {
    
    var id: String {
        get
    }
    
    var clusterIdentifier: String? {
        get
    }
    
    var glyphImage: UIImage? {
        get
    }
    
    var tintColor: UIColor? {
        get
    }
    
}

extension MKMapView {
    
    var mapAnnotations: [MapAnnotation] {
        self.annotations.filterMapAnnotations()
    }
    
    var selectedMapAnnotations: [MapAnnotation] {
        self.selectedAnnotations.filterMapAnnotations()
    }
    
}

extension Array where Element: MKAnnotation {
    
    func filterMapAnnotations() -> [MapAnnotation] {
        self.filter { $0 is MapAnnotation }
            .map { $0 as! MapAnnotation }
    }
    
}
