//
//  ExampleAnnotation.swift
//  MapViewExample
//
//  Created by Sören Gade on 21.02.20.
//

import SwiftUIMapView
import MapKit

class ExampleAnnotation: NSObject, MapViewAnnotation, Identifiable {
    
    let coordinate: CLLocationCoordinate2D
    
    let title: String?
    
    let id = UUID()
    
    let clusteringIdentifier: String? = "exampleCluster"
    
    let glyphImage: UIImage? = UIImage(systemName: "e.circle.fill")
    
    let tintColor: UIColor? = .green
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
}

extension Array where Element == ExampleAnnotation {
    static var examples: [ExampleAnnotation] = {
        [
            ExampleAnnotation(title: "Apple Park", coordinate: .applePark),
            ExampleAnnotation(title: "Infinite Loop", coordinate: .inifiniteLoop),
        ]
    }()
}
