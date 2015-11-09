//
//  LoginVC+Animation.swift
//  LoginScreen
//
//  Created by Oleksandr Nechet on 09.11.15.
//  Copyright © 2015 Oleksandr Nechet. All rights reserved.
//

import UIKit

extension LoginVC {
    var animationDuration: Double {
        get {
            return 0.4
        }
    }
    
    func expandSocialButton(button: OLNSocialButton) {
        let willBeginExpanding = !button.expanded
        button.toggleExpand()
        var viewForAnim = Set(button.superview!.subviews)
        viewForAnim.remove(button)
        viewForAnim.insert(textFieldEmail)
        viewForAnim.insert(textFieldPassw)
        for  view in viewForAnim{
            view.layer.addAnimation(self.animationFade(fade:willBeginExpanding), forKey: nil)
            view.alpha = willBeginExpanding ? 0 : 1
        }
        viewUserProfileInfo.layer.addAnimation(self.animationFade(fade:!willBeginExpanding), forKey: nil)
        viewUserProfileInfo.alpha = !willBeginExpanding ? 0 : 1
        
        layoutConstraintSpacingToViewUserProfileInfo.priority = willBeginExpanding ? 999 : 250
        UIView.animateWithDuration(self.animationDuration) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    /**
     * moves view with social buttons
     */
    func animationForSocial(present: Bool) -> CAAnimationGroup {
        if present == Bool(viewSocialBtns.alpha) {
            return CAAnimationGroup()
        }
        viewSocialBtns.alpha = present ? 1.0 : 0.0
        
        let animSlide = CABasicAnimation(keyPath: "position.y")
        let newPosition = viewSocialBtns.center.y + 2 * viewSocialBtns.frame.size.height
        animSlide.fromValue = present ? newPosition : viewSocialBtns.center.y
        animSlide.toValue = present ? viewSocialBtns.center.y : newPosition
        
        let animGroup = CAAnimationGroup()
        animGroup.animations = [animSlide, self.animationFade(fade:!present)]
        animGroup.duration = animationDuration
        return animGroup
    }
    
    /**
     * @param fade: if set false - inverse animation
     */
    func animationFade(fade fade:Bool) -> CABasicAnimation {
        let animFade = CABasicAnimation(keyPath: "opacity")
        animFade.fromValue = fade ? 1.0 : 0.0
        animFade.toValue = fade ? 0.0 : 1.0
        animFade.duration = animationDuration
        return animFade
    }
}
