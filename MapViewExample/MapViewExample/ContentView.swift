//
//  ContentView.swift
//  MapViewExample
//
//  Created by Sören Gade on 21.02.20.
//

import SwiftUI
import SwiftUIMapView
import CoreLocation
import MapKit

struct ContentView: View {

    @State
    var region: MKCoordinateRegion? = MKCoordinateRegion(
        center: .applePark,
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
    )

    @State
    var selectedAnnotations: [MapViewAnnotation] = []

    let type: MKMapType = .standard

    let trackingMode: MKUserTrackingMode = .none

    let annotations: [MapViewAnnotation] = [ExampleAnnotation].examples

    let locationManager = CLLocationManager()

    var body: some View {
        VStack {
            MapView(
                mapType: type,
                region: $region,
                userTrackingMode: trackingMode,
                annotations: annotations,
                selectedAnnotations: $selectedAnnotations
            )
            .edgesIgnoringSafeArea(.all)

            ForEach(selectedAnnotations.compactMap { $0 as? ExampleAnnotation }) { annotation in
                Text("\( annotation.title ?? "" )")
            }

            if let region {
                Text("\(region.center.latitude), \(region.center.longitude)")
            }
        }
        .onAppear {
            // this is required to display the user's current location
            locationManager.requestWhenInUseAuthorization()
        }
    }

}

// MARK: - Previews

#Preview {
    ContentView()
}
