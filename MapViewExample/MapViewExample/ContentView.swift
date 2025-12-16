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
    private var region: MKCoordinateRegion? = MKCoordinateRegion(
        center: .applePark,
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
    )

    @State
    private var selectedAnnotations: [MapViewAnnotation] = []

    private let locationManager = CLLocationManager()

    var body: some View {
        VStack {
            MapView(
                mapType: .standard,
                region: $region,
                showsUserLocation: true,
                userTrackingMode: .none,
                annotations: [ExampleAnnotation].examples,
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
