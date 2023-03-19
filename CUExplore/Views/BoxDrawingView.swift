//
//  BoxDrawingView.swift
//  CUExplore
//
//  Created by Tom Miller on 19/03/2023.
//

import UIKit
import Vision

final class BoxDrawingView: UIView {
    
    func drawBox(with predictions: [VNRecognizedObjectObservation]) {
        layer.sublayers?.forEach {
            $0.removeFromSuperlayer()
        }
        
        predictions.forEach {
            drawBox(with: $0)
        }
    }
    
    private func drawBox(with prediction: VNRecognizedObjectObservation) {
        let scale = CGAffineTransform.identity.scaledBy(x: bounds.width, y: bounds.height)
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)
        
        let rectangle = prediction.boundingBox.applying(transform).applying(scale)
        
        let newlayer = CALayer()
        newlayer.frame = rectangle
        
        newlayer.backgroundColor = UIColor.red.withAlphaComponent(0.5).cgColor
        newlayer.cornerRadius = 4
        
        layer.addSublayer(newlayer)
    }
}

