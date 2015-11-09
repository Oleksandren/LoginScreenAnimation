//
//  OLNLoginButton.swift
//  LoginScreen
//
//  Created by Oleksandr Nechet on 09.11.15.
//  Copyright © 2015 Oleksandr Nechet. All rights reserved.
//

import UIKit

class OLNLoginButton: UIButton {
    
    func present(show: Bool) {
        if show != hidden {
            return
        }
        self.hidden = false
        let initialRect = CGRectMake(self.bounds.width/2.0, 0, 0, 0)
        let initialPath = UIBezierPath(ovalInRect: initialRect).CGPath
        
        let h = self.frame.size.height - CGRectGetMaxY(initialRect)
        let w = self.frame.size.width - CGRectGetMaxX(initialRect)
        let radius = sqrt((h * h) + (w * w))
        let finalParh = UIBezierPath(ovalInRect: CGRectInset(initialRect, -radius, -radius)).CGPath
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = (show ? initialPath : finalParh)
        maskLayerAnimation.toValue = (show ? finalParh : initialPath)
        maskLayerAnimation.duration = 0.4
        if !show {
            maskLayerAnimation.delegate = self
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.addAnimation(maskLayerAnimation, forKey: nil)
        maskLayer.path = (show ? finalParh : initialPath)
        self.layer.mask = maskLayer
    }
    
    //MARK: - CAAnimation Delegate
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.hidden = true
    }
}
