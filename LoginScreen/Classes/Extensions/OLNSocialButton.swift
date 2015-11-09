//
//  OLNSocialButton.swift
//  LoginScreen
//
//  Created by Oleksandr Nechet on 09.11.15.
//  Copyright © 2015 Oleksandr Nechet. All rights reserved.
//

import UIKit


class OLNSocialButton: UIButton {
    @IBOutlet weak var layoutConstraintWidth: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintLeadingSpace: NSLayoutConstraint?
    @IBInspectable var expandedSize: CGSize = CGSizeZero
    var expanded = false
    var drawExpandedBackground = false
    var initialBounds: CGRect!
    
    var animationDuration: Double {
        get {
            return 0.4
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialBounds = self.bounds
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        return self.initialBounds
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if drawExpandedBackground {
            let context = UIGraphicsGetCurrentContext()
            CGContextSaveGState(context);
            CGContextAddRect(context, CGContextGetClipBoundingBox(context));
            CGContextAddArc(context, 19, 19, 19, 0, CGFloat(Float(M_PI) * 2), 0)
            CGContextClosePath(context);
            CGContextEOClip(context);
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, 168, 0);
            CGContextAddLineToPoint(context, 168, 38);
            CGContextAddLineToPoint(context, 0, 38);
            CGContextAddLineToPoint(context, 0, 0);
            CGContextSetRGBFillColor(context, 0.75, 0.75, 0.75, 0.5);
            CGContextFillPath(context);
            CGContextRestoreGState(context);
        }
    }
    
    func toggleExpand() {
        guard self.checkSettings() else {
            return
        }
        if !expanded {
            self.moveToStartPosition { () -> Void in
                self.expand()
            }
        } else {
            self.expand()
        }
    }
    
    func checkSettings() -> Bool {
        if CGSizeEqualToSize(expandedSize, CGSizeZero) {
            print("Expanded Size must be setted in IB")
            return false
        }
        if (layoutConstraintWidth == nil) {
            print("Setup layout Constraint Width for button in IB")
            return false
        }
        return true
    }
    
    /// Before start expanding, button must be moved to left
    /// - Parameter directionBack: if true - move button right
    /// - Parameter completionHandler: invoked when animation finished
    func moveToStartPosition(completionHandler completionHandler: (() ->Void)?) {
        if (layoutConstraintLeadingSpace != nil) {
            layoutConstraintLeadingSpace?.priority = expanded ? 250 : 999
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                self.layoutIfNeeded()
                }, completion: { (compleated) -> Void in
                    if compleated {
                        if completionHandler != nil {
                            completionHandler!()
                        }
                    }
            })
        } else {
            if completionHandler != nil {
                completionHandler!()
            }
        }
    }
    
     func expand () {
        if !expanded {
            layoutConstraintWidth.constant = expandedSize.width
            self.layoutIfNeeded()
            drawExpandedBackground = true
            self.setNeedsDisplay()
        }
        let initialCornerRadius = max(CGRectGetHeight(initialBounds), CGRectGetWidth(initialBounds))
        let initialPath = UIBezierPath(roundedRect: initialBounds, cornerRadius: initialCornerRadius).CGPath
        let finalCornerRadius = max(expandedSize.width, expandedSize.height)
        let finalRect = CGRectMake(0, 0, expandedSize.width, expandedSize.height)
        let finalParh  = UIBezierPath(roundedRect: finalRect, cornerRadius: finalCornerRadius).CGPath
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = (expanded ? finalParh : initialPath)
        maskLayerAnimation.toValue = (expanded ? initialPath : finalParh)
        maskLayerAnimation.duration = animationDuration
        maskLayerAnimation.delegate = self
        
        let maskLayer = CAShapeLayer()
        maskLayer.addAnimation(maskLayerAnimation, forKey: nil)
        maskLayer.path = (expanded ? initialPath : finalParh)
        self.layer.mask = maskLayer
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if expanded {
            layoutConstraintWidth.constant = initialBounds.size.width
            self.layoutIfNeeded()
            drawExpandedBackground = false
            self.setNeedsDisplay()
            moveToStartPosition(completionHandler: { () -> Void in
                self.expanded = false
            })
        } else {
            self.expanded = true
        }
    }
}






















