//
//  FLSignInUpAbstractCell.swift
//  FLSignInUpFlow-swift
//
//  Created by Florian Lecluse on 6/12/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

import UIKit
//MARK: -
//MARK: - FLSignInUpAbstractCellProtocol
//MARK: -
protocol FLSignInUpAbstractCellProtocol {
    func nextTouchUpInside(indexPath: IndexPath)
}
//MARK: -
//MARK: - FLSignInUpAbstractCell Class
//MARK: -
class FLSignInUpAbstractCell: UITableViewCell {
    var delegate : FLSignInUpAbstractCellProtocol?
    var indexPath : IndexPath!
    var item : FLSignInUpViewItem?
    var errorView : FLSignInUpAccessoryView?
    func performWithItem(_ item: FLSignInUpViewItem) {}
    func textFieldBecomeFirstResponder() {}
}
