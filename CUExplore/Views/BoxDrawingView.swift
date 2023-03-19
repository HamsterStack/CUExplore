//
//  BoxDrawingView.swift
//  CUExplore
//
//  Created by Tom Miller on 19/03/2023.
//

import UIKit
import Vision

final class BoxDrawingView: UIView {
  
  var label: String = ""
  var confidence: Int = 0
    
    func drawBox(with predictions: [VNRecognizedObjectObservation]) {
        layer.sublayers?.forEach {
            $0.removeFromSuperlayer()
        }
        
        predictions.forEach {
          let identifier = $0.labels[0].identifier
          let confidence = $0.labels[0].confidence
          
          let formattedString = NSMutableAttributedString(string: String(format: "\(identifier)\nConfidence:  %.2f", confidence))
          let largeFont = UIFont(name: "Helvetica", size: 24.0)!
          print(formattedString)
          drawBox(with: $0, label: formattedString.string)
        }
    }
    
  private func drawBox(with prediction: VNRecognizedObjectObservation, label: String) {
    let scale = CGAffineTransform.identity.scaledBy(x: bounds.width, y: bounds.height)
    let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)

    let rectangle = prediction.boundingBox.applying(transform).applying(scale)

    let textLayer = CATextLayer()
    textLayer.frame = CGRect(x: 10, y: 50, width: 230, height: 21)
    textLayer.string = label
    textLayer.foregroundColor = UIColor.green.cgColor
    textLayer.backgroundColor = UIColor.clear.cgColor
    textLayer.fontSize = 17.0
    textLayer.font = UIFont.systemFont(ofSize: 17)

    let newlayer = CALayer()
    newlayer.frame = rectangle
  
    newlayer.cornerRadius = 4

    newlayer.addSublayer(textLayer)
    self.layer.addSublayer(newlayer)
    }
}

