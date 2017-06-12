//
//  FLSignInUpSocialCell.swift
//  FLSignInUpFlow-swift
//
//  Created by Florian Lecluse on 6/12/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

import UIKit

class FLSignInUpSocialCell: FLSignInUpAbstractCell {
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    override func performWithItem(_ item: FLSignInUpViewItem) {
        self.item = item
        self.facebookButton.titleLabel?.font = UIFont(name: (self.facebookButton.titleLabel!.font?.fontName)!, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline).pointSize)
        self.googleButton.titleLabel?.font = UIFont(name: (self.googleButton.titleLabel!.font?.fontName)!, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline).pointSize)
    }
    @IBAction func facebookTouchUpInside(_ sender: UIButton) {
        FLSignInUpViewModel.sharedInstance.facebookSSO()
    }
    @IBAction func googleTouchUpInside(_ sender: UIButton) {
        FLSignInUpViewModel.sharedInstance.googleSSO()
    }
}
