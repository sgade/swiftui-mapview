# swiftui-mapview

![Swift Version](https://img.shields.io/badge/Swift-6.2-orange.svg?logo=swift)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsgade%2Fswiftui-mapview%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/sgade/swiftui-mapview)
![Platforms](https://img.shields.io/badge/Platforms-iOS-yellow.svg?logo=apple)

[MKMapView](https://developer.apple.com/documentation/mapkit/mkmapview) in SwiftUI.

**For iOS 17 and later, I recommend you use Apple's official [Map](https://developer.apple.com/documentation/mapkit/map) view.**

[![Social Preview](assets/social-preview.png)](assets/screen.png)
(Click the image to see the full screenshot)

## Install

Using Xcode, select `File` -> `Swift Packages` -> `Add Package Dependency` and enter `https://github.com/sgade/swiftui-mapview`.

## Usage

In your view, add the map.
See the [example project](MapViewExample) for how to integrate the map view.

```swift
import SwiftUIMapView

struct ContentView: View {
    var body: some View {
        MapView()
    }
}
```

## Configuration

### Map type

```swift
MapView(mapType: .standard)
```

### User location

### Showing the current user location

The current location can be shown on the map.
Note that the application requires permission to access the current user location.
See the documentation on `MapView.showsUserLocation` for more information.

```swift
MapView(showsUserLocation: true)
```

### Tracking the user's location

```swift
MapView(userTrackingMode: .follow)
```

### Setting the visible region

The binding passed in for `region` defines the visible map region. Use it to define the visible center and zoom.
Setting it to `nil` will use the map's default region when loaded. It is also updated when the visible region changes.

```swift
@State var region: MKCoordinateRegion?

MapView(region: $region)
```

### Annotations

#### Adding annotations

Annotations are represented as objects of a custom class that implements the `MapViewAnnotation` protocol.
It might be helpful to subclass from existing classes like `MKPlacemark`.

```swift
let annotations: [MapViewAnnotation] = ...

MapView(annotations: annotations)
```

#### Selecting annotations

A list of selected annotations can be passed in via a binding.

```swift
@State var selectedAnnotations: [MapViewAnnotation] = []

MapView(selectedAnnotations: $selectedAnnotations)
```

## Contributing

See the [contributing guide](CONTRIBUTING.md).

## License

This project is licensed unter the terms of the MIT license. See [LICENSE](./LICENSE) for more information.
