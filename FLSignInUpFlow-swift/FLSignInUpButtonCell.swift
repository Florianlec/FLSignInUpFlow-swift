//
//  FLSignInUpButtonCell.swift
//  FLSignInUpFlow-swift
//
//  Created by Florian Lecluse on 6/12/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

import UIKit

class FLSignInUpButtonCell: FLSignInUpAbstractCell {
    @IBOutlet weak var button: UIButton!
    override func performWithItem(_ item: FLSignInUpViewItem) {
        self.item = item
        self.button.setTitle(self.item?.title, for: UIControlState())
        self.button.titleLabel?.font = UIFont(name: (self.button.titleLabel!.font?.fontName)!, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline).pointSize)
    }
    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        if self.item?.title == FLSignInUpViewModelLocalizedStringConstants.login {
            FLSignInUpViewModel.sharedInstance.login()
        } else if self.item?.title == FLSignInUpViewModelLocalizedStringConstants.signup {
            FLSignInUpViewModel.sharedInstance.signup()
        } else if self.item?.title == FLSignInUpViewModelLocalizedStringConstants.forgorYourPassword {
            FLSignInUpViewModel.sharedInstance.forgorPassword()
        }
    }
}
