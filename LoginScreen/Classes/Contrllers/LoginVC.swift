//
//  LoginVC.swift
//  LoginScreen
//
//  Created by Oleksandr Nechet on 09.11.15.
//  Copyright © 2015 Oleksandr Nechet. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var buttonLogin: OLNLoginButton!
    @IBOutlet weak var viewSocialBtns: UIView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassw: UITextField!
    @IBOutlet weak var imageViewUserPhoto: UIImageView!
    @IBOutlet weak var viewUserProfileInfo: UIView!
    @IBOutlet weak var layoutConstraintSpacingToViewUserProfileInfo: NSLayoutConstraint!
    var buttonSelected: OLNSocialButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewUserPhoto.layer.borderColor = UIColor.whiteColor().CGColor
        imageViewUserPhoto.layer.borderWidth = 2
        imageViewUserPhoto.layer.cornerRadius = imageViewUserPhoto.bounds.size.height / 2.0
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        buttonLogin.present(true)
        viewSocialBtns.layer.addAnimation(self.animationForSocial(false), forKey: nil)
    }
    
    //MARK: - IBActions
    
    @IBAction func useSocial(sender: OLNSocialButton) {
        if sender.expanded {
            //Do Sign In
            switch sender.tag {
            case 101:
                print("tw")
            case 102:
                print("fb")
            case 103:
                print("q+")
            default:
                print("setup tags in Social buttons")
            }
        }else{
            buttonSelected = sender
            expandSocialButton(sender)
        }
    }
    
    @IBAction func endEditing(_: AnyObject) {
        if (buttonSelected != nil) {
            expandSocialButton(buttonSelected!)
            buttonSelected = nil
        } else {
            buttonLogin.present(false)
            viewSocialBtns.layer.addAnimation(self.animationForSocial(true), forKey: nil)
            self.view.endEditing(true)
        }
    }
}




