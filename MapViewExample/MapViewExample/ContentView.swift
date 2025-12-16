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

    let type: MKMapType = .standard
    @State var region: MKCoordinateRegion? = MKCoordinateRegion(center: .applePark, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    let trackingMode: MKUserTrackingMode = .none
    let annotations: [MapViewAnnotation] = [ExampleAnnotation].examples
    @State var selectedAnnotations: [MapViewAnnotation] = []

    var body: some View {
        VStack {
            MapView(mapType: self.type,
                    region: self.$region,
                    userTrackingMode: self.trackingMode,
                    annotations: self.annotations,
                    selectedAnnotations: self.$selectedAnnotations)
            .edgesIgnoringSafeArea(.all)

            ForEach(self.selectedAnnotations.compactMap { $0 as? ExampleAnnotation }) { annotation in
                Text("\( annotation.title ?? "" )")
            }

            if self.region != nil {
                Text("\( self.regionToString(self.region!) )")
            }
        }
        .onAppear {
            // this is required to display the user's current location
            self.requestLocationUsage()
        }
    }

    func regionToString(_ region: MKCoordinateRegion) -> String {
        "\(region.center.latitude), \(region.center.longitude)"
    }

    let locationManager = CLLocationManager()
    private func requestLocationUsage() {
        self.locationManager.requestWhenInUseAuthorization()
    }

}

// MARK: - Previews

#Preview {
    ContentView()
}
