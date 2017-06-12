//
//  FLTableViewController.swift
//  FLSignInUpFlow-swift
//
//  Created by Florian Lecluse on 6/12/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

import UIKit
//MARK: -
//MARK: - FLTableViewController Class
//MARK: -
class FLTableViewController: UIViewController {
    //MARK: -
    //MARK: - Attributes
    //MARK: -
    @IBOutlet weak var tableView: UITableView!
    var isKeyboardOpen = false
    //MARK: -
    //MARK: - Attributes
    //MARK: -
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterForKeyboardNotifications()
    }
    //MARK: -
    //MARK: - Private Methods
    //MARK: -
    func p_manageTableViewItems() {}
    //MARK: -
    //MARK: - NSNotification Methods
    //MARK: -
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(FLTableViewController.keyboardDidShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FLTableViewController.keyboardDidHide(_:)), name: NSNotification.Name.UIKeyboardDidHide, object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FLTableViewController.keyboardDidChangeFrame(_:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FLTableViewController.didChangePreferredContentSize(_:)), name: NSNotification.Name.UIContentSizeCategoryDidChange, object:nil)
    }
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object:nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object:nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidChangeFrame, object:nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object:nil)
    }
    func keyboardDidShow(_ notification: Notification) {
        if self.isKeyboardOpen {
            return
        }
        self.isKeyboardOpen = true
        let keyBoardSize = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue.size
        let rate = (notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        self.resizeTableViewWithKeyboardSize(keyBoardSize, rate: rate!)
    }
    func keyboardDidHide(_ notification: Notification) {
        if (self.isKeyboardOpen == false) {
            return
        }
        self.isKeyboardOpen = false
        let rate = (notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        let heigth = (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.size.height
        let contentInsets = UIEdgeInsetsMake(heigth, UIEdgeInsets.zero.left, UIEdgeInsets.zero.bottom, UIEdgeInsets.zero.right)
        UIView.animate(withDuration: rate!, animations: { () -> Void in
            self.tableView.contentInset = contentInsets
            self.tableView.scrollIndicatorInsets = contentInsets
        })
    }
    func keyboardDidChangeFrame(_ notification: Notification) {
        if (self.isKeyboardOpen == true) {
            let keyBoardSize = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue.size
            let rate = (notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
            self.resizeTableViewWithKeyboardSize(keyBoardSize, rate: rate!)
        }
    }
    func resizeTableViewWithKeyboardSize(_ keyBoardSize:CGSize, rate:Double) {
        let contentInsets : UIEdgeInsets
        let heigth = (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.size.height
        contentInsets = UIEdgeInsetsMake(heigth, 0.0, (keyBoardSize.height), 0.0)
        UIView.animate(withDuration: rate, animations: { () -> Void in
            self.tableView.contentInset = contentInsets
            self.tableView.scrollIndicatorInsets = contentInsets
        })
    }
    func didChangePreferredContentSize(_ notification: Notification) {
        self.p_manageTableViewItems()
    }
}
