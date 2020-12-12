//
//  MapView.swift
//  SwiftUIMapView
//
//  Created by Sören Gade on 14.01.20.
//  Copyright © 2020 Sören Gade. All rights reserved.
//

import SwiftUI
import MapKit

/// Displays a map. The contents of the map are provided by the Apple Maps service.
///
/// See the [official documentation](https://developer.apple.com/documentation/mapkit/mkmapview)
/// for more information on the possibilities provided by the underlying service.
///
/// - Author: Sören Gade
/// - Copyright: © 2020 Sören Gade
@available(iOS, introduced: 13.0)
@available(iOS, deprecated: 14.0, message: "Please consider using the official Map view.")
public struct MapView: UIViewRepresentable {

    // MARK: Properties

    /// The map type that is displayed.
    let mapType: MKMapType

    /// The filter used to determine the points of interest shown on the map.
    let pointOfInterestFilter: MKPointOfInterestFilter?

    /// The region that is displayed.
    ///
    /// - Note: The region might not be used as-is, as it might need to be fitted to the view's bounds.
    ///         See [regionThatFits(_:)](https://developer.apple.com/documentation/mapkit/mkmapview/1452371-regionthatfits).
    @Binding var region: MKCoordinateRegion?

    /// Determines whether the map can be zoomed.
    let isZoomEnabled: Bool

    /// Determines whether the map can be scrolled.
    let isScrollEnabled: Bool

    /// Determines whether the current user location is displayed.
    ///
    /// - Warning: This requires the `NSLocationWhenInUseUsageDescription` key in the Info.plist to be set.
    ///            In addition, you need to call [CLLocationManager.requestWhenInUseAuthorization()](https://developer.apple.com/documentation/corelocation/cllocationmanager/1620562-requestwheninuseauthorization) to request for permission.
    let showsUserLocation: Bool

    /// Sets the map's user tracking mode.
    let userTrackingMode: MKUserTrackingMode

    /// Annotations that are displayed on the map.
    ///
    /// See the `selectedAnnotation` binding for more information about user selection of annotations.
    ///
    /// - SeeAlso: selectedAnnotation
    let annotations: [MapViewAnnotation]

    /// The currently selected annotations.
    ///
    /// When the user selects annotations on the map the value of this binding changes.
    /// Likewise, setting the value of this binding to a value selects the given annotations.
    @Binding var selectedAnnotations: [MapViewAnnotation]

    // MARK: Initializer

    /// Creates a new `MapView`.
    ///
    /// - Parameters:
    ///   - mapType: The map type to display.
    ///   - region: The region to display.
    ///   - showsUserLocation: Whether to display the user's current location.
    ///   - userTrackingMode: The user tracking mode.
    ///   - annotations: A list of `MapAnnotation`s that should be displayed on the map.
    ///   - selectedAnnotation: A binding to the currently selected annotation, or `nil`.
    public init(
        mapType: MKMapType = .standard,
        pointOfInterestFilter: MKPointOfInterestFilter? = nil,
        region: Binding<MKCoordinateRegion?> = .constant(nil),
        isZoomEnabled: Bool = true,
        isScrollEnabled: Bool = true,
        showsUserLocation: Bool = true,
        userTrackingMode: MKUserTrackingMode = .none,
        annotations: [MapViewAnnotation] = [],
        selectedAnnotations: Binding<[MapViewAnnotation]> = .constant([])
    ) {
        self.mapType = mapType
        self.pointOfInterestFilter = pointOfInterestFilter
        self._region = region
        self.isZoomEnabled = isZoomEnabled
        self.isScrollEnabled = isScrollEnabled
        self.showsUserLocation = showsUserLocation
        self.userTrackingMode = userTrackingMode
        self.annotations = annotations
        self._selectedAnnotations = selectedAnnotations
    }

    // MARK: - UIViewRepresentable
    
    public func makeCoordinator() -> MapView.Coordinator {
        return Coordinator(for: self)
    }

    public func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        // Create view
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        // Register custom annotation view classes
        mapView.register(MapAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(MapAnnotationClusterView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)

        // Configure initial view state
        mapView.mapType = self.mapType
        mapView.pointOfInterestFilter = self.pointOfInterestFilter
        mapView.isZoomEnabled = self.isZoomEnabled
        mapView.isScrollEnabled = self.isScrollEnabled
        mapView.showsUserLocation = self.showsUserLocation
        mapView.userTrackingMode = self.userTrackingMode

        region.map { mapView.setRegion($0, animated: false) }

        self.configureView(mapView, context: context)

        return mapView
    }

    public func updateUIView(_ mapView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        // configure view update
        self.configureView(mapView, context: context)
    }

    // MARK: - Configuring view state

    /// Configures the `mapView`'s state according to the current view state.
    private func configureView(_ mapView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        // Basic map configuration
        region.map { mapRegion in
            let region = mapView.regionThatFits(mapRegion)

            if region != mapView.region {
                mapView.setRegion(region, animated: true)
            }
        }

        // Annotation configuration
        self.updateAnnotations(in: mapView)
        self.updateSelectedAnnotation(in: mapView)
    }

    /// Updates the annotation property of the `mapView`.
    /// Calculates the difference between the current and new states
    /// and only executes changes on those diff sets.
    ///
    /// - Parameters:
    ///   - mapView: The `MKMapView` to configure.
    private func updateAnnotations(in mapView: MKMapView) {
        let currentAnnotations = mapView.mapViewAnnotations
        // remove old annotations
        let obsoleteAnnotations = currentAnnotations.filter { mapAnnotation in
            !self.annotations.contains { $0.isEqual(mapAnnotation) }
        }
        mapView.removeAnnotations(obsoleteAnnotations)

        // add new annotations
        let newAnnotations = self.annotations.filter { mapViewAnnotation in
            !currentAnnotations.contains { $0.isEqual(mapViewAnnotation) }
        }
        mapView.addAnnotations(newAnnotations)
    }

    /// Updates the selection annotations of the `mapView`.
    /// Calculates the difference between the current and new selection states
    /// and only executes changes on those diff sets.
    ///
    /// - Parameters:
    ///   - mapView: The `MKMapView` to configure.
    private func updateSelectedAnnotation(in mapView: MKMapView) {
        // Deselect annotations that are not currently selected
        let oldSelections = mapView.selectedMapViewAnnotations.filter { oldSelection in
            !self.selectedAnnotations.contains {
                oldSelection.isEqual($0)
            }
        }
        for annotation in oldSelections {
            mapView.deselectAnnotation(annotation, animated: false)
        }

        // Select all new annotations
        let newSelections = self.selectedAnnotations.filter { selection in
            !mapView.selectedMapViewAnnotations.contains {
                selection.isEqual($0)
            }
        }
        for annotation in newSelections {
            mapView.selectAnnotation(annotation, animated: true)
        }
    }

    // MARK: - Interaction and delegate implementation

    public class Coordinator: NSObject, MKMapViewDelegate {

        /// Reference to the SwiftUI `MapView`.
        private let context: MapView

        init(for context: MapView) {
            self.context = context
            super.init()
        }

        // MARK: MKMapViewDelegate

        public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let mapAnnotation = view.annotation as? MapViewAnnotation else {
                return
            }

            DispatchQueue.main.async {
                self.context.selectedAnnotations.append(mapAnnotation)
            }
        }

        public func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            guard let mapAnnotation = view.annotation as? MapViewAnnotation else {
                return
            }

            guard let index = self.context.selectedAnnotations.firstIndex(where: { $0.isEqual(mapAnnotation) }) else {
                return
            }

            DispatchQueue.main.async {
                self.context.selectedAnnotations.remove(at: index)
            }
        }

        public func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            DispatchQueue.main.async {
                self.context.region = mapView.region
            }
        }

    }

}

#if DEBUG

// MARK: - SwiftUI Preview

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
