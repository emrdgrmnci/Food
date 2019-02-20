//
//  GraidentView.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 18.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

@IBDesignable
class GraidentView: UIView {
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map{$0.cgColor}
        
        if (self.isHorizontal) {
            layer.startPoint = CGPoint(x: 0, y: 0.5)
            layer.endPoint = CGPoint (x: 1, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0.5, y: 0)
            layer.endPoint = CGPoint (x: 0.5, y: 1)
        }
    }
    
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
        override class var layerClass: AnyClass {
        get {
        return CAGradientLayer.self
        }
        }
        
        @IBInspectable var isHorizontal: Bool = true {
        didSet {
        updateView()
        }
        }
}


