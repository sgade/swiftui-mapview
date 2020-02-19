//
//  MapView.swift
//  swiftui-mapview
//
//  Created by Sören Gade on 14.01.20.
//  Copyright © 2020 Sören Gade. All rights reserved.
//

import SwiftUI
import MapKit
import Combine
import UIKit

/**
 The MapView displays a map. The contents of the map are provided by the Apple Maps service.
 
 See the [official documentation](https://developer.apple.com/documentation/mapkit/mkmapview) for more information on the possibilities provided by the underlying service.
 */
struct MapView: UIViewRepresentable {
    let mapType: MKMapType
    @Binding var center: CLLocationCoordinate2D?
    @Binding var zoom: MKCoordinateSpan
    let showsUserLocation: Bool
    let userTrackingMode: MKUserTrackingMode
    let annotations: [MapAnnotation]
    @Binding var selectedAnnotation: MapAnnotation?

    init(mapType: MKMapType = .standard,
         center: Binding<CLLocationCoordinate2D?> = .constant(nil),
         zoom: Binding<MKCoordinateSpan> = .constant(MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)),
         showsUserLocation: Bool = true,
         userTrackingMode: MKUserTrackingMode = .none,
         annotations: [MapAnnotation] = [],
         selectedAnnotation: Binding<MapAnnotation?> = .constant(nil)) {
        self.mapType = mapType
        self._center = center
        self._zoom = zoom
        self.showsUserLocation = showsUserLocation
        self.userTrackingMode = userTrackingMode
        self.annotations = annotations
        self._selectedAnnotation = selectedAnnotation
    }

    func makeCoordinator() -> MapView.Coordinator {
        return Coordinator(for: self)
    }

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        // create view
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.register(MapAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(MapAnnotationClusterView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)

        // configure view
        self.configureView(mapView, context: context)

        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        self.configureView(mapView, context: context)
    }

    private func configureView(_ mapView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        // keep the documentation in mind: https://developer.apple.com/documentation/mapkit/mkmapview
        
        // basic map configuration
        mapView.mapType = self.mapType
        if let center = self.center {
            let region = MKCoordinateRegion(center: center, span: self.zoom)
            mapView.setRegion(mapView.regionThatFits(region), animated: true)
        }
        mapView.showsUserLocation = self.showsUserLocation
        mapView.userTrackingMode = self.userTrackingMode
        
        self.updateAnnotations(in: mapView)
        self.updateSelectedAnnotation(in: mapView)
    }
    
    private func updateAnnotations(in mapView: MKMapView) {
        let currentAnnotations = mapView.mapAnnotations
        let obsoleteAnnotations = currentAnnotations.filter { mapAnnotation in
            !self.annotations.contains { $0.isEqual(mapAnnotation) }
        }
        mapView.removeAnnotations(obsoleteAnnotations)
        
        let newAnnotations = self.annotations.filter { mapAnnotation in
            !currentAnnotations.contains { $0.isEqual(mapAnnotation) }
        }
        mapView.addAnnotations(newAnnotations)
    }
    
    private func updateSelectedAnnotation(in mapView: MKMapView) {
        let selections = [ self.selectedAnnotation ].compactMap { $0 }
        
        // oldSelections.excluding(contentsOf: selections)
        let oldSelections = mapView.selectedMapAnnotations.filter { oldSelection in
            !selections.contains {
                oldSelection.isEqual($0)
            }
        }
        // deselect annotations that are not currently selected
        for annotation in oldSelections {
            mapView.deselectAnnotation(annotation, animated: false)
        }
        
        // selections.excluding(contentsOf: mapView.selectedMapAnnotations)
        let newSelections = selections.filter { selection in
            !mapView.selectedMapAnnotations.contains {
                selection.isEqual($0)
            }
        }
        // select all new annotations
        for annotation in newSelections {
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        private let context: MapView
        
        private let visibleRegionProxy = PassthroughSubject<MKCoordinateRegion, Never>()
        private let backgroundQueue = DispatchQueue(label: "MapViewBackground", qos: .userInitiated)
        
        private var disposables = Set<AnyCancellable>()
        
        init(for context: MapView) {
            self.context = context
            super.init()
            
            self.visibleRegionProxy.debounce(for: .milliseconds(250), scheduler: self.backgroundQueue)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] region in
                    self?.context.center = region.center
                    self?.context.zoom = region.span
                }
                .store(in: &self.disposables)
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let mapAnnotation = view.annotation as? MapAnnotation else {
                return
            }
            
            self.context.selectedAnnotation = mapAnnotation
        }
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            guard view.annotation is MapAnnotation else {
                return
            }
            
            self.context.selectedAnnotation = nil
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            let region = mapView.region
            self.visibleRegionProxy.send(region)
        }
    }
}

#if DEBUG
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
#endif
