//
//  MapAnnotationClusterView.swift
//  SwiftUIMapView
//
//  Created by Sören Gade on 19.02.20.
//  Copyright © 2020 Sören Gade. All rights reserved.
//

import Foundation
import MapKit

/**
 Custom annotation view for `MapAnnotation` view clusters.
 
 This view draws its content itself and therefore has a pretty custom style.
 
 - SeeAlso: MapAnnotationView
 */
class MapAnnotationClusterView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            if let clusterAnnotation = newValue as? MKClusterAnnotation {
                let mapAnnotations = clusterAnnotation.memberAnnotations.compactMap { $0 as? MapViewAnnotation }
                guard let mapAnnotation = mapAnnotations.first else {
                    return
                }
                
                self.collisionMode = .circle
                
                let size = CGSize(width: 32, height: 32)
                self.image = self.drawGlyph(sized: size, colored: mapAnnotation.tintColor, withCount: mapAnnotations.count)
            }
        }
    }
    
    /**
     Draws the annotation's glyph.
     */
    private func drawGlyph(sized size: CGSize, colored tintColor: UIColor?, withCount count: Int) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            // draw background
            tintColor?.setFill()
            UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size.width, height: size.height)).fill()
            
            if let image = UIImage(systemName: "\(count).circle")?
                .withTintColor(.white) {
                // draw glyph
                let imageRect = CGRect(x: size.width / 2 - image.size.width / 2,
                                       y: size.height / 2 - image.size.height / 2,
                                       width: image.size.width,
                                       height: image.size.height)
                image.draw(in: imageRect)
            } else {
                // draw text
                let fontSize: CGFloat = 24
                let textAttributes: [NSAttributedString.Key: NSObject] = [
                    NSAttributedString.Key.foregroundColor: UIColor.black,
                    NSAttributedString.Key.font: UIFont(name: "Roboto", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
                ]
                let text = "\(count)" as NSString
                let textSize = text.size(withAttributes: textAttributes)
                let textRect = CGRect(x: size.width / 2 - textSize.width / 2,
                                      y: size.height / 2 - textSize.height / 2,
                                      width: textSize.width,
                                      height: textSize.height)
                text.draw(in: textRect, withAttributes: textAttributes)
            }
        }
    }
    
}
