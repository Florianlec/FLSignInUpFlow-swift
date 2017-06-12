//
//  FLSignInUpViewItem.swift
//  FLSignInUpFlow-swift
//
//  Created by Florian Lecluse on 6/12/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

import UIKit
//MARK: -
//MARK: - FLSignInUpViewItemConstants Class
//MARK: -
struct FLSignInUpViewItemConstants {
    static let standardCell = "FLSignInUpStandardCell"
    static let socialCell = "FLSignInUpSocialCell"
    static let buttonCell = "FLSignInUpButtonCell"
}
//MARK: -
//MARK: - FLSignInUpViewItem Class
//MARK: -
class FLSignInUpViewItem: NSObject {
    var identifier = ""
    var title = ""
    var key = ""
    var value = ""
    var detailTitle = ""
    var error = ""
    init(identifier: String, title: String, key: String, value: String , detailTitle: String, error: String) {
        self.identifier = identifier
        self.title = title
        self.key = key
        self.value = value
        self.detailTitle = detailTitle
        self.error = error
    }
}
