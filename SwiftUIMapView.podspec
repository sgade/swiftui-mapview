Pod::Spec.new do |spec|
  spec.name          = "SwiftUIMapView"
  spec.version       = "1.0.0"
  spec.summary       = "MKMapView in SwiftUI"
  spec.description   = <<-DESC
  Allows you to use MKMapview in your SwiftUI app on iOS.
                   DESC

  spec.homepage      = "https://github.com/sgade/swiftui-mapview"
  spec.screenshots   = "https://github.com/sgade/swiftui-mapview/raw/master/assets/screen.png"

  spec.license       = { :type => "MIT", :file => "LICENSE" }
  spec.authors       = { "Sören Gade" => "gade.soeren@gmail.com" }

  spec.platform      = :ios, "13.0"
  spec.source        = { :git => "https://github.com/sgade/swiftui-mapview.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/SwiftUIMapView/**/*.swift"
  spec.swift_version = "5.1"
end
